//
//  CoasterItemView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct CoasterItemView: View {
    @State private var coaster: Coaster
    @ObservedObject var vm: CoasterItemViewModel
    @State private var isPressed = false
    
    init(coaster: Coaster) {
        self.coaster = coaster
        self.vm = CoasterItemViewModel(coaster: coaster)
    }
    
    var body: some View {
        NavigationLink(destination: CoasterDetailsView(id: coaster.id, liked: $vm.liked, isPressed: $isPressed)) {
            HStack {
                ImageView(id: coaster.id, size: "280x210", width: 160, height: 120)
                VStack(alignment: .leading) {
                    Text(coaster.name)
                        .font(.title)
                        .bold()
                    Text(coaster.park.name)
                        .font(.callout)
                    Text(vm.coaster.rank != nil ? "Rank: \(coaster.rank!)" : "No rank yet")
                        .font(.footnote)
                    Text(coaster.cleanedUpStatusString())
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: vm.liked ? "heart.fill" : "heart")
                    .foregroundStyle(vm.liked ? .red : .blue)
            }
        }
    }
}

struct CoasterItem_Preview: PreviewProvider {
    static var previews: some View {
        CoasterItemView(coaster: Coaster(id: 1, name: "Test", park: CoastersPark(name: "Home"), status: CoastersStatus(name: "operating"), rank: 1))
    }
}
