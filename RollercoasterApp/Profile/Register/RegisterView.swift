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
                HeaderView(
                    title: "Register",
                    subtitle: "Create Your Account",
                    bgColor: LinearGradient(
                        gradient: .init(colors: [Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255), Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.6)
                        ),
                    angle: -15)
                
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
