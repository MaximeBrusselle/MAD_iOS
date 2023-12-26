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
    @Published var liked = false
    
    init (coaster: Coaster) {
        self.coaster = coaster
        checkIfCoasterLiked()
    }
    
    func checkIfCoasterLiked() {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("coasters")
            .document("\(coaster.id)")
            .addSnapshotListener { [weak self] document, error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if document?.exists ?? false {
                        self.liked = true
                    } else {
                        self.liked = false
                    }
                }
            }
    }
}
