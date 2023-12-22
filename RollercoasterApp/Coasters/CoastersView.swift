//
//  CoastersView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct CoastersView: View {
    private let userId: String
    @StateObject private var vm = CoastersViewModel()
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.repo.hydraMember.isEmpty {
                    Text("Something went wrong")
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 14){
                            ForEach(vm.repo.hydraMember, id: \.id) { coaster in
                                CoasterItemView(coaster: coaster)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Coasters")
        }

        
       
    }
}

struct Coasters_Preview: PreviewProvider {
    static var previews: some View {
        CoastersView(userId: "yJp8qLL65QV02RgEzfm794bX21V2")
    }
}
