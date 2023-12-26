//
//  CoasterDetailsViewController.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class CoasterDetailsViewModel: ObservableObject {
    let id: Int
    @Published var coaster = CoasterDetail()
    @Published var doneFetching = false
    @Published var errorMessage = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(id: Int){
        self.id = id
    }

    
    func fetchCoaster() {
        let url = URL(string: "https://captaincoaster.com/api/coasters/\(self.id)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/ld+json", forHTTPHeaderField: "accept")
        request.addValue(PlistReader().getPlistProperty(withName: "keys", withValue: "CaptainCoasterApiKey")!, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: CoasterDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.doneFetching = true
                    break // Do nothing on success
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    self.doneFetching = true
                }
            }, receiveValue: { [weak self] detail in
                guard let self = self else { return }
                self.coaster = detail
                self.doneFetching = true
            })
            .store(in: &cancellables)
    }
    
    func toggleLike(liked: Bool) -> Bool {
        // Get current user
        guard let uId = Auth.auth().currentUser?.uid else {
            return liked
        }
        
        // Save model
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uId)
        
        if liked {
            userRef.collection("coasters")
                .document("\(id)")
                .delete()
            userRef.updateData([
                "coastersRidden": FieldValue.increment(-1.0)
            ])
        } else {
            userRef.collection("coasters")
                .document("\(id)")
                .setData(coaster.asDictionary())
            userRef.updateData([
                "coastersRidden": FieldValue.increment(1.0)
            ])
        }
        return !liked
    }
}
