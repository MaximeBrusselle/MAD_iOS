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
            ImageView(id: coaster.id, size: "280x210", width: 160, height: 160)
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
            Image(systemName: $vm.liked.wrappedValue ? "heart.fill" : "heart")
                .foregroundStyle($vm.liked.wrappedValue ? .red : .blue)
                .onChange(of: $vm.liked.wrappedValue) {
                    debugPrint("haha")
                }
        }
    }
}

struct CoasterItem_Preview: PreviewProvider {
    static var previews: some View {
        CoasterItemView(coaster: Coaster(id: 1, name: "Test", park: CoastersPark(name: "Home"), status: CoastersStatus(name: "operating"), rank: 1))
    }
}
