//
//  RegisterViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func register() {
        guard validate() else {
            return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard error == nil else {
                self?.errorMessage = error!.localizedDescription
                return
            }
            guard let user = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: user)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, coastersRidden: 0)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    //https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    private func checkIfEmail(email str: String) -> Bool {
        let emailFormat = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: str)
    }
    
    private func validate() -> Bool {
        self.errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.errorMessage = "Please fill in all fields."
            return false
        }
        
        guard checkIfEmail(email: email) else {
            self.errorMessage = "Please enter valid email."
            return false
        }
        
        guard password.count >= 6 else {
            self.errorMessage = "Password must be atleast 6 characters"
            return false
        }
        
        return true
    }
}

