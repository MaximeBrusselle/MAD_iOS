//
//  ProfileViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    let userId: String
    @Published var user: User? = nil
    
    init(userId: String) {
        self.userId = userId
        self.fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        let db = Firestore.firestore()
        db.collection("users")
            .document(self.userId)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.user = User(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        coastersRidden: data["coastersRidden"] as? Int ?? 0)
                }
            }
    }
    
    func logout() {
        do {
           try Auth.auth().signOut()
        } catch {
            debugPrint("Something happened")
        }
    }
    
    func deleteItem(id: Int) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(self.userId)
        userRef.collection("coasters")
            .document(id.description)
            .delete()
        userRef.updateData([
            "coastersRidden": FieldValue.increment(-1.0)
        ])
    }
}
