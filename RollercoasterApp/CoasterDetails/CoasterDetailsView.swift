//
//  CoasterDetailsView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct CoasterDetailsView: View {
    private let id: Int
    @Binding private var liked: Bool
    @ObservedObject private var vm: CoasterDetailsViewModel
    
    init(id: Int, liked: Binding<Bool>) {
        self.id = id
        self._liked = liked
        self.vm = CoasterDetailsViewModel(id: id)
        vm.fetchCoaster()
    }
    
    var body: some View {
        if vm.doneFetching {
            if vm.errorMessage.isEmpty {
                VStack(spacing: 10) {
                    Text("\(vm.coaster.id!): \(vm.coaster.name!)")
                    Button {
                        liked = vm.toggleLike(liked: liked)
                    } label: {
                        Image(systemName: liked ? "heart.fill" : "heart")
                            .foregroundStyle(liked ? .red : .blue)
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
    @State static var liked = false
    static var previews: some View {
        CoasterDetailsView(id: 300, liked: $liked)
    }
}

