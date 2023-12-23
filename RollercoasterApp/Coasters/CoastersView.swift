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
    
    init(userId: String) {
        self.userId = userId
        self.vm = CoastersViewModel()
        vm.fetchCoasters(page: 7)
    }
    
    var body: some View {
        NavigationView {
            if vm.doneFetching {
                if vm.errorMessage.isEmpty {
                    VStack {
                        List {
                            ForEach(vm.repo.items, id: \.id) { coaster in
                                NavigationLink(destination: CoasterDetailsView(id: coaster.id)) {
                                    CoasterItemView(coaster: coaster)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .navigationTitle("Coasters")
                } else {
                    Text(vm.errorMessage)
                }
                
            } else {
                ProgressView()
            }
            
        }
    }
}

struct Coasters_Preview: PreviewProvider {
    static var previews: some View {
        CoastersView(userId: PlistReader().getPlistProperty(withName: "keys", withValue: "testUserId")!)
    }
}
