//
//  RollercoasterAppApp.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI
import FirebaseCore

@main
struct RollercoasterAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    @StateObject var detailmodel = CoasterDetailsViewModel(id: 1)
    @StateObject var listmodel = CoastersViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
