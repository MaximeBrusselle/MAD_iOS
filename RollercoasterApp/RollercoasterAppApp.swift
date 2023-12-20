//
//  RollercoasterAppApp.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import SwiftUI

@main
struct RollercoasterAppApp: App {
    @StateObject var model = CoasterDetailsViewModel(id: 1)
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
