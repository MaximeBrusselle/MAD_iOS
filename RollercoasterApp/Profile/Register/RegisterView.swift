//
//  RegisterView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var vm = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Register", subtitle: "Create Your Account", bgColor: .pink, angle: -15)
                
                Form {
                    if !vm.errorMessage.isEmpty {
                        Text(vm.errorMessage)
                            .foregroundStyle(.red)
                    }
                    TextField("Full Name", text: $vm.name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .textContentType(.name)
                    
                    TextField("Email Address", text: $vm.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    
                    TextField("Password", text: $vm.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .textContentType(.password)
                        
                    AccountButton(text: "Create Account", bgColor: .green) {
                        vm.register()
                    }
                    .padding()
                }
                .offset(y: -50)
                Spacer()
            }
        }
    }
}

#Preview {
    RegisterView()
}
