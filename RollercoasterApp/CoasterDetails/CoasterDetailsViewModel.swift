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
    
    init(id: Int){
        self.id = id
    }

    
    func fetchCoaster() {
        let url = URL(string: "https://captaincoaster.com/api/coasters/\(self.id)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/ld+json", forHTTPHeaderField: "accept")
        request.addValue(PlistReader().getPlistProperty(withName: "keys", withValue: "CaptainCoasterApiKey")!, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if error != nil {
                self.errorMessage = error!.localizedDescription
            } else if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase

                        let coasterDetail = try decoder.decode(CoasterDetail.self, from: data!)
                        
                        DispatchQueue.main.async {
                            self.coaster = coasterDetail
                            self.doneFetching = true
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                            self.doneFetching = true
                        }

                    }
                case 401:
                    DispatchQueue.main.async {
                        self.errorMessage = "Authorization issue (401)"
                        self.doneFetching = true
                    }
                case 404:
                    DispatchQueue.main.async {
                        self.errorMessage = "Resource not found (404)"
                        self.doneFetching = true
                    }
                default:
                    DispatchQueue.main.async {
                        self.errorMessage = "Unexpected response: \(response.statusCode)"
                        self.doneFetching = true
                    }
                }
            }
        }

        task.resume()
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
