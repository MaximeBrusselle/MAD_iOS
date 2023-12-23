//
//  ImageView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 21/12/2023.
//

import SwiftUI

struct ImageView: View {
    let id: Int
    let size: String
    let width: Double
    let height: Double
    @ObservedObject private var vm: ImageViewModel
    
    init(id: Int, size: String, width: Double, height: Double) {
        self.id = id
        self.size = size
        self.width = width
        self.height = height
        self.vm = ImageViewModel(id: id, size: size)
        vm.fetchImage()
    }
    
    var body: some View {
        if vm.doneFetching {
            AsyncImage(url: vm.imageURL.isEmpty ? nil : URL(string: vm.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
            } placeholder: {
                ZStack {
                    Rectangle()
                        .frame(width: width, height: height)
                        .foregroundStyle(.gray)
                    Text("No Image Found")
                        .foregroundStyle(.white)
                }
                
            }
       } else {
           ProgressView()
       }
    }
}

#Preview {
    ImageView(id: 1, size: "280x210", width: 140, height: 120)
}
