//
//  CoastersViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation
import Alamofire

class CoastersViewModel: ObservableObject {
    @Published var repo: CoastersRepo = .init(items: [])
    @Published var doneFetching = false
    @Published var errorMessage = ""
    
    func fetchCoasters(page: Int) {
        let url = URL(string: "https://captaincoaster.com/api/coasters?page=\(page)")!

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

                        let coasterRepo = try decoder.decode(CoastersRepo.self, from: data!)
                        
                        DispatchQueue.main.async {
                            self.repo = coasterRepo
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
}
