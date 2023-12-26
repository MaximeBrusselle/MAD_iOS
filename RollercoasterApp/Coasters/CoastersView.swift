//
//  CoastersView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct CoastersView: View {
    private let userId: String
    @ObservedObject var vm: CoastersViewModel
    @State var searchterm = ""
    @State var searched = false
    @State private var selectedCoaster: Coaster?
    
    init(userId: String) {
        self.userId = userId
        self.vm = CoastersViewModel()
        vm.fetchCoasters()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("previous") {
                        vm.fetchPrevCoasters()
                    }
                    .opacity(vm.isOnFirstPage ? 0.0 : 1.0)
                    .disabled(!vm.doneFetching)
                    
                    Spacer()
                    Button("next") {
                        vm.fetchNextCoasters()
                    }
                    .disabled(!vm.doneFetching)
                    .opacity(vm.hasNextPage ? 1.0 : 0.0)
                }
                .padding(.horizontal)
                if !vm.doneFetching {
                    Spacer()
                }
                if vm.doneFetching {
                    if vm.errorMessage.isEmpty {
                        List {
                            ForEach(vm.repo.items, id: \.id) { coaster in
                                CoasterItemView(coaster: coaster)
                            }
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        Text(vm.errorMessage)
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Coasters")
            .searchable(text: $searchterm, prompt: "Search a coaster")
            .onChange(of: searchterm ) {
                if searchterm.isEmpty, searched == true {
                    vm.searchCoasters(searchTerm: "")
                    searched = false
                }
            }
            .onSubmit(of: .search) {
                vm.searchCoasters(searchTerm: searchterm)
                searched = true
            }
        }
    }
}

struct Coasters_Preview: PreviewProvider {
    static var previews: some View {
        CoastersView(userId: PlistReader().getPlistProperty(withName: "keys", withValue: "testUserId")!)
    }
}
