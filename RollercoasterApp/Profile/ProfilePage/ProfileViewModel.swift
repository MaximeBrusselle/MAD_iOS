//
//  ProfileViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    init() {
        
    }
    
    func logout() {
        do {
           try Auth.auth().signOut()
        } catch {
            debugPrint("Something happened")
        }

    }
}
