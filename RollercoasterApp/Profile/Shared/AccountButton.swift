//
//  AccountButton.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct AccountButton: View {
    let text: String
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(bgColor)
                Text(text)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    AccountButton(text: "Title", bgColor: .green) {
        
    }
}
