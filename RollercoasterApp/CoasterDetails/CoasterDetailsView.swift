//
//  CoasterDetailsView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct CoasterDetailsView: View {
    @StateObject private var vm = CoasterDetailsViewModel(id: 1)
    
    var body: some View {
        if vm.coaster.name != nil {
            Text(vm.coaster.name!)
        } else {
            Text("Something went wrong")
        }

    }
}

struct CoasterDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        CoasterDetailsView()
    }
}

