//
//  HeaderView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let bgColor: LinearGradient
    let angle: Double
    let padding: Double
    let offset: Double
    let width: Double
    let height: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(bgColor)
                .rotationEffect(.degrees(angle))
            
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
            }
            .padding(.top, padding)
        }
        .frame(width: width, height: height)
        .offset(y: offset)
    }
}

#Preview {
    HeaderView(
        title: "Title",
        subtitle: "Subtitle",
        bgColor: LinearGradient(
        gradient: .init(colors: [Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255), Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)]),
        startPoint: .init(x: 0.5, y: 0),
        endPoint: .init(x: 0.5, y: 0.6)
        ), 
        angle: 15,
        padding: 80,
        offset: -150,
        width: UIScreen.main.bounds.width * 2, 
        height: 350
    )
}
