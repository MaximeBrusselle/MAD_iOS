//
//  ProfileView.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @FirestoreQuery var items: [Coaster]
    init(userId: String){
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/coasters")
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Your liked coasters")
                }
                List(items) { item in
                    Text("\(item.name)")
                }
                AccountButton(text: "Log Out", bgColor: .red, action: vm.logout)
                    .frame(width: 300, height: 50)
                .padding()
                Spacer()
            }
            .navigationTitle("Profile")
        }

    }
}

#Preview {
    ProfileView(userId: PlistReader().getPlistProperty(withName: "keys", withValue: "testUserId")!)
}
