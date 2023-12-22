//
//  ImageView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 21/12/2023.
//

import SwiftUI

struct ImageView: View {
    @StateObject private var vm = ImageViewModel(id: 1, size: "280x210")
    
    var body: some View {
        if vm.isDataLoaded {
           AsyncImage(url: URL(string: vm.imageURL))
       } else {
           // You can show a loading indicator or placeholder here
           Text("Loading...")
       }
    }
}

#Preview {
    ImageView()
}
