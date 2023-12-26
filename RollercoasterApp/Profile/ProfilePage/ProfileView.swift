//
//  ProfileView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ProfileView: View {
    @StateObject var vm: ProfileViewModel
    @FirestoreQuery var items: [Coaster]
    init(userId: String){
        self._vm = StateObject(wrappedValue: ProfileViewModel(userId: userId))
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/coasters")
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                //User
                if let user = vm.user {
                    profileInfo(user: user)
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
                
                //Sign out
                AccountButton(text: "Log Out", bgColor: .red, action: vm.logout)
                    .frame(width: 300, height: 50)
                .padding()
                Spacer()
            }
            .navigationTitle("Profile")
            .padding(.horizontal)
        }
    }
    @ViewBuilder
    func profileInfo(user: User) -> some View {
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
    }
}

#Preview {
    ProfileView(userId: PlistReader().getPlistProperty(withName: "keys", withValue: "testUserId")!)
}
