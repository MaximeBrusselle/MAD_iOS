//
//  LoginView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
            LoginViews()
        }
    }
}

struct LoginViews: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var body: some View {
        if horizontalSizeClass == .compact, verticalSizeClass == .regular {
            VStack {
                HeaderView(
                    title: "Coaster App",
                    subtitle: "Your Favourite Coasters",
                    bgColor: LinearGradient(
                        gradient: .init(colors: [Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255), Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.6)
                    ),
                    angle: 15,
                    padding: 80,
                    offset: -150,
                    width: UIScreen.main.bounds.width * 2,
                    height: 350
                )
                
                LoginForm()
                    .offset(y: -50)
                
                VStack {
                    Text("Dont have an account yet?")
                    NavigationLink("Create Account", destination: RegisterView())
                    
                }
                Spacer()
            }
        } else {
            HStack {
                HeaderView(
                    title: "Coaster App",
                    subtitle: "Your Favourite Coasters",
                    bgColor: LinearGradient(
                        gradient: .init(colors: [Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255), Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.6)
                    ),
                    angle: 0,
                    padding: 0,
                    offset: 0,
                    width: UIScreen.main.bounds.width / 2,
                    height: UIScreen.main.bounds.height * 1.2
                )
                
                VStack {
                    LoginForm()
                    
                    VStack {
                        Text("Dont have an account yet?")
                        NavigationLink("Create Account", destination: RegisterView())
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoginForm: View {
    @StateObject var vm = LoginViewModel()
    var body: some View {
        Form {
            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .foregroundStyle(.red)
            }
            TextField("Email Address", text: $vm.email)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
                .textContentType(.emailAddress)
            SecureField("Password", text: $vm.password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)
                .textContentType(.password)
            
            AccountButton(text: "Log In", bgColor: .blue) {
                vm.login()
            }
            .padding()
        }
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
