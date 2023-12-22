//
//  CoasterItemView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct CoasterItemView: View {
    var coaster: Coaster
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoasterItem_Preview: PreviewProvider {
    static var previews: some View {
        CoasterItemView(coaster: Coaster(id: 1, name: "Test", park: CoastersPark(name: "Home"), status: CoastersStatus(name: "operating")))
    }
}
