//
//  CoastersView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct CoastersView: View {
    @StateObject private var vm = CoastersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.repo.hydraMember.isEmpty {
                    Text("Something went wrong")
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 14){
                            ForEach(vm.repo.hydraMember, id: \.id) { coaster in
                                VStack(spacing: 14) {
                                    Text(coaster.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }

        
       
    }
}

struct Coasters_Preview: PreviewProvider {
    static var previews: some View {
        CoastersView()
    }
}
