//
//  LoginView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Coaster App", subtitle: "Your Favourite Coasters", bgColor: .orange, angle: 15)
                
                
                
                Form {
                    if !vm.errorMessage.isEmpty {
                        Text(vm.errorMessage)
                            .foregroundStyle(.red)
                    }
                    TextField("Email Address", text: $vm.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .textContentType(.emailAddress)
                    TextField("Password", text: $vm.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .textContentType(.password)
                    
                    AccountButton(text: "Log In", bgColor: .blue) {
                        vm.login()
                    }
                    .padding()
                }
                .offset(y: -50)
                
                VStack {
                    Text("Dont have an account yet?")
                    NavigationLink("Create Account", destination: RegisterView())
                    
                }
                Spacer()
            }
        }

    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
