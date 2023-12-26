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
    let path: String?
    @ObservedObject private var vm: ImageViewModel
    
    init(id: Int, size: String, width: Double, height: Double) {
        self.id = id
        self.size = size
        self.width = width
        self.height = height
        self.path = nil
        self.vm = ImageViewModel(id: id, size: size)
        vm.fetchImage()
    }
    
    init(size: String, width: Double, height: Double, path: String?){
        self.id = 0
        self.size = size
        self.width = width
        self.height = height
        self.path = path
        self.vm = ImageViewModel(size: size)
        vm.getImageUrl(path: path)
    }
    
    var body: some View {
        VStack {
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
               ZStack {
                   Rectangle()
                       .frame(width: width, height: height)
                       .foregroundStyle(.gray)
                   Text("Loading")
               }

           }
        }
    }
}

#Preview {
    VStack {
        ImageView(id: 1, size: "280x210", width: 160, height: 120)
        ImageView(size: "280x210", width: 160, height: 120, path: "872e0fc8-7e29-4093-95d1-36db6f2a0340.jpeg")
    }
}
