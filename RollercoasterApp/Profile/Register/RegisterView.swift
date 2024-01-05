//
//  RegisterView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        NavigationView {
            RegisterViews()
        }
    }
}

struct RegisterViews: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var body: some View {
        if horizontalSizeClass == .compact, verticalSizeClass == .regular  {
            VStack {
                HeaderView(
                    title: "Register",
                    subtitle: "Create Your Account",
                    bgColor: LinearGradient(
                        gradient: .init(colors: [Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255), Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.6)
                    ),
                    angle: -15,
                    padding: 80,
                    offset: -150,
                    width: UIScreen.main.bounds.width * 2,
                    height: 350
                )
                RegisterForm()
                    .offset(y: -50)
                Spacer()
            }
        } else {
            HStack {
                HeaderView(
                    title: "Register",
                    subtitle: "Create Your Account",
                    bgColor: LinearGradient(
                        gradient: .init(colors: [Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255), Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.6)
                    ),
                    angle: 0,
                    padding: 0,
                    offset: 0,
                    width: UIScreen.main.bounds.width / 2,
                    height: UIScreen.main.bounds.height * 1.2
                )
                RegisterForm()
            }
        }
    }
}

struct RegisterForm: View {
    @StateObject var vm = RegisterViewModel()
    var body: some View {
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
    }
}


#Preview {
    RegisterView()
}
