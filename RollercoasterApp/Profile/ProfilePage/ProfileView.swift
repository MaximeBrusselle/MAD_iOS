//
//  ProfileView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                AccountButton(text: "Log Out", bgColor: .red, action: vm.logout)
                .padding()
                Spacer()
            }
            .navigationTitle("Profile")
        }

    }
}

#Preview {
    ProfileView()
}
