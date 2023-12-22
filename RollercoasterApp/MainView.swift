//
//  ContentView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var vm = MainViewModel()
    var body: some View {
        if vm.isSignedIn, !vm.currentUserId.isEmpty {
            TabView {
                CoastersView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        } else {
            LoginView()
        }
    }
}
    
#Preview {
    MainView()
}
