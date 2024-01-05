//
//  ProfileView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ProfileView: View {
    var userId: String
    var body: some View {
        NavigationView {
            ProfileViews(userId: userId)
        }
    }
}

struct ProfileViews: View {
    @StateObject var vm: ProfileViewModel
    @FirestoreQuery var items: [Coaster]
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    init(userId: String){
        self._vm = StateObject(wrappedValue: ProfileViewModel(userId: userId))
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/coasters")
    }
    
    var body: some View {
        if horizontalSizeClass == .compact, verticalSizeClass == .regular {
            VStack {
                if let user = vm.user {
                    ProfileInfo(user: user)
                    Divider()
                    
                    HStack {
                        Text("Coasters ridden")
                            .bold()
                            .font(.title2)
                        Spacer()
                        Text(user.coastersRidden.description)
                            .bold()
                            .font(.title3)
                    }
                    
                    List(items) { item in
                        Text("\(item.name)")
                            .swipeActions {
                                Button("Remove") {
                                    vm.deleteItem(id: item.id)
                                }
                                .tint(.red)
                            }
                    }
                    
                    AccountButton(text: "Log Out", bgColor: .red, action: vm.logout)
                        .frame(width: 300, height: 50)
                    .padding()
                    Spacer()
                } else {
                    Text("Something went wrong")
                }
            }
            .navigationTitle("Profile")
            .padding(.horizontal)
        } else {
            HStack {
                if let user = vm.user {
                    VStack {
                        ProfileInfo(user: user)
                        AccountButton(text: "Log Out", bgColor: .red, action: vm.logout)
                            .frame(width: 200, height: 50)
                            .padding()
                        Spacer()
                    }
                    
                    
                    VStack {
                        HStack {
                            Text("Coasters ridden")
                                .bold()
                                .font(.title2)
                            Spacer()
                            Text(user.coastersRidden.description)
                                .bold()
                                .font(.title3)
                        }
                        
                        List(items) { item in
                            Text("\(item.name)")
                                .swipeActions {
                                    Button("Remove") {
                                        vm.deleteItem(id: item.id)
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                } else {
                    Text("Something went wrong")
                }
            }
            .padding()
        }
    }
}

struct ProfileInfo: View {
    var user: User
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.blue)
            .frame(width: 125, height: 125)
        Text(user.name)
            .bold()
            .font(.largeTitle)
        Text(user.email)
            .font(.title2)
    }
}

#Preview {
    ProfileView(userId: PlistReader().getPlistProperty(withName: "keys", withValue: "testUserId")!)
}
