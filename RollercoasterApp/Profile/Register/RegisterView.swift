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
                        .autocorrectionDisabled()
                        .textContentType(.name)
                    
                    TextField("Email Address", text: $vm.email)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    
                    SecureField("Password", text: $vm.password)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
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
