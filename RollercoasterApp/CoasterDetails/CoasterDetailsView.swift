//
//  CoasterDetailsView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct CoasterDetailsView: View {
    private let id: Int
    @ObservedObject private var vm: CoasterDetailsViewModel
    
    init(id: Int) {
        self.id = id
        self.vm = CoasterDetailsViewModel(id: id)
        vm.checkIfCoasterLiked()
        vm.fetchCoaster()
    }
    
    var body: some View {
        if vm.doneFetching {
            if vm.errorMessage.isEmpty {
                VStack(spacing: 10) {
                    Text("\(vm.coaster.id!): \(vm.coaster.name!)")
                    Button {
                        vm.toggleLike()
                    } label: {
                        Image(systemName: vm.liked ? "heart.fill" : "heart")
                            .foregroundStyle(vm.liked ? .red : .blue)
                    }
                }
            } else {
                Text(vm.errorMessage)
            }
        } else {
            ProgressView()
        }
    }
}

struct CoasterDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        CoasterDetailsView(id: 300)
    }
}

