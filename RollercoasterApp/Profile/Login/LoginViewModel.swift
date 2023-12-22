//
//  LoginViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    //https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    private func checkIfEmail(email str: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: str)
    }
    
    private func validate() -> Bool {
        self.errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.errorMessage = "Please fill in all fields."
            return false
        }
        
        guard checkIfEmail(email: email) else {
            self.errorMessage = "Please enter valid email."
            return false
        }
        
        return true
    }
}
