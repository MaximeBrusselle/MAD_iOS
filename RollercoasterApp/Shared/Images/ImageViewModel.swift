//
//  ImageViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 21/12/2023.
//

import Foundation
import Alamofire

class ImageViewModel: ObservableObject {
    var id: Int
    var size: String
    @Published var repo: ImageRepo = .init(items: [], amount: nil)
    @Published var imageURL = ""
    @Published var doneFetching = false
    @Published var errorMessage = ""
    
    init(id: Int, size: String) {
        self.id = id
        self.size = size
    }
    
    init(size: String){
        self.id = 0
        self.size = size
    }
    

    
    func fetchImage() {
        let url = URL(string: "https://captaincoaster.com/api/images?page=1&coaster=\(self.id)")!

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

                        let imageRepo = try decoder.decode(ImageRepo.self, from: data!)
                        
                        DispatchQueue.main.async {
                            self.repo = imageRepo
                            self.imageURL = self.getImageUrl()
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
    
    func getImageUrl(path: String?) {
        self.imageURL = path != nil ? "https://pictures.captaincoaster.com/\(self.size)/\(path!)" : ""
        self.doneFetching = true
    }
    
    
    func getImageUrl() -> String {
        if let _ = repo.amount, repo.amount != 0 {
            return "https://pictures.captaincoaster.com/\(self.size)/\(repo.items.first!.path!)"
        }
        
        return ""
    }
}
