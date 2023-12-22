//
//  CoasterItemViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class CoasterItemViewModel: ObservableObject {
    let coaster: Coaster
    @Published var likeId = ""
    
    init (coaster: Coaster) {
        self.coaster = coaster
    }
    
    func like() {
        
        // Get current user
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create model
        let newItem = coaster
        
        // Save model
        let db = Firestore.firestore()
        let ref = db.collection("users").document(uId)
        
        ref.collection("coasters")
            .document("\(coaster.id)")
            .setData(newItem.asDictionary())
        
        ref.updateData([
            "coastersRidden": FieldValue.increment(1.0)
        ])
        
        likeId = "\(coaster.id)"
    }
    
    func removelike() {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard !likeId.isEmpty else {
            return
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("users").document(uId)
        
        ref.collection("coasters")
            .document(likeId)
            .delete()
        
        ref.updateData([
            "coastersRidden": FieldValue.increment(-1.0)
        ])
        
        likeId = ""
    }
}
