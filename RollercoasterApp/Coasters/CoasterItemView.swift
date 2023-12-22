//
//  CoasterItemView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct CoasterItemView: View {
    private var coaster: Coaster
    @ObservedObject var vm: CoasterItemViewModel
    
    init(coaster: Coaster) {
        self.coaster = coaster
        self.vm = CoasterItemViewModel(coaster: coaster)
    }
    
    var body: some View {
        HStack {
            Text(coaster.name)
            if vm.likeId.isEmpty {
                likeButton(action: vm.like, color: .blue, label: "Add")
            } else {
                likeButton(action: vm.removelike, color: .red, label: "Remove")
            }
        }
    }
    
    struct likeButton: View {
        var action: () -> Void
        var color: Color
        var label: String
        
        var body: some View {
            Button {
                action()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 40)
                        .foregroundStyle(color)
                    Text(label)
                        .foregroundStyle(.white)
                }
            }
        }
        
    }
}

struct CoasterItem_Preview: PreviewProvider {
    static var previews: some View {
        CoasterItemView(coaster: Coaster(id: 1, name: "Test", park: CoastersPark(name: "Home"), status: CoastersStatus(name: "operating")))
    }
}
