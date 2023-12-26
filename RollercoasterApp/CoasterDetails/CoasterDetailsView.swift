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
    @Binding private var isPressed: Bool
    @ObservedObject private var vm: CoasterDetailsViewModel
    
    init(id: Int, liked: Binding<Bool>, isPressed: Binding<Bool>) {
        self.id = id
        self._liked = liked
        self._isPressed = isPressed
        self.vm = CoasterDetailsViewModel(id: id)
        if isPressed.wrappedValue {
            vm.fetchCoaster()
        }
    }
    
    var body: some View {
        VStack {
            if vm.doneFetching {
                if vm.errorMessage.isEmpty {
                    ZStack {
                        ImageView(size: "280x210", width: 350, height: 262.5, path: vm.coaster.mainImage?.path)
                        Button {
                            liked = vm.toggleLike(liked: liked)
                        } label: {
                            ZStack {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(liked ? .pink : .white)
                                Image(systemName: "heart")
                                    .font(.system(size: 60))
                                    .foregroundStyle(.black)
                            }
                        }
                        .offset(x: 160, y: 120)
                    }
                    Text(vm.coaster.name!)
                        .bold()
                        .font(.system(size: 60))
                    VStack {
                        // this for some reason makes the divider be better tucked under title
                    }
                    Divider()
                    CoasterInformationView(coaster: vm.coaster)
                    Spacer()
                } else {
                    Text(vm.errorMessage)
                }
            } else {
                ProgressView()
            }
        }
        .padding(.horizontal)
        .onAppear {
            isPressed = true
        }
        .onDisappear {
            isPressed = false
        }
    }
    
    struct CoasterInformationView: View {
        let coaster: CoasterDetail
        var generalInfo: [[String]]
        var extraInfo: [[String]]
        
        init(coaster: CoasterDetail) {
            self.coaster = coaster
            self.generalInfo = [
                [
                    "Manufacturer: ",
                    coaster.getProperty(property: coaster.manufacturer?.name)
                ],
                [
                    "Park: ",
                    coaster.getProperty(property: coaster.park?.name),
                    coaster.getProperty(property: coaster.park?.country?.name, start: "country.")
                ],
                [
                    "Height: ",
                    coaster.getProperty(property: coaster.height?.description)
                ],
                [
                    "Length: ",
                    coaster.getProperty(property: coaster.length?.description)
                ],
                [
                    "Speed: ",
                    coaster.getProperty(property: coaster.speed?.description)
                ],
                [
                    "Inversions: ",
                    coaster.getProperty(property: coaster.inversionsNumber?.description)
                ],
                [
                    "Openingdate: ",
                    coaster.convertToDate(from: coaster.getProperty(property: coaster.openingDate?.description))
                ],
                [
                    "Status: ",
                    coaster.getProperty(property: coaster.status?.name, start: "status.")
                ],
            ]
            
            if coaster.getProperty(property: coaster.status?.name, start: "status.") == "Closed definitely" {
                self.generalInfo.append([
                    "Closingdate:",
                    coaster.convertToDate(from: coaster.getProperty(property: coaster.closingDate?.description))
                ])
            }
            
            self.extraInfo = [
                [
                    "Model: ",
                    coaster.getProperty(property: coaster.model?.name)
                ],
                [
                    "Material: ",
                    coaster.getProperty(property: coaster.materialType?.name)
                ],
                [
                    "Seating: ",
                    coaster.getProperty(property: coaster.seatingType?.name)
                ],
                [
                    "Restraint: ",
                    coaster.getProperty(property: coaster.restraint?.name, start: "restraint.")
                ],
            ]
        }
        
        var body: some View {
            List {
                CoasterDetailsSection(
                    title: "General Information",
                    information: self.generalInfo
                )
                CoasterDetailsSection(
                    title: "Extra Information",
                    information: self.extraInfo
                )
            }
            .background(.white)
        }
    }
    
    struct CoasterDetailsSection: View {
        var title: String
        var information: [[String]]
        var body: some View {
            Section(title) {
                ForEach(information.indices, id: \.self) { index in
                    CoasterDetailsSectionItem(messages: information[index])
                }
            }
        }
    }
    
    struct CoasterDetailsSectionItem: View {
        var messages: [String]
        
        var body: some View {
            HStack {
                ForEach(messages, id: \.self) { message in
                    Text(message)
                }
            }
        }
    }

}

struct CoasterDetailsView_Preview: PreviewProvider {
    @State static var liked = false
    @State static var isPressed = true

    static var previews: some View {
        CoasterDetailsView(id: 1, liked: $liked, isPressed: $isPressed)
    }
}

