//
//  ImageViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 21/12/2023.
//

import Foundation
import Combine


class ImageViewModel: ObservableObject {
    var id: Int
    var size: String
    @Published var repo: ImageRepo = .init(items: [], amount: nil)
    @Published var imageURL = ""
    @Published var doneFetching = false
    @Published var errorMessage = ""
    private var cancellables: Set<AnyCancellable> = []
    
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
            .decode(type: ImageRepo.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    self.doneFetching = true
                }
            }, receiveValue: { [weak self] imageRepo in
                guard let self = self else { return }
                self.repo = imageRepo
                self.imageURL = self.getImageUrl()
                self.doneFetching = true
            })
            .store(in: &cancellables)
    }
    
    func getImageUrl(path: String?) {
        self.imageURL = path != nil ? "https://pictures.captaincoaster.com/\(self.size)/\(path!)" : ""
        self.doneFetching = true
    }
    
    
    func getImageUrl() -> String {
        guard let amount = repo.amount, amount != 0 else {
            return ""
        }
        return "https://pictures.captaincoaster.com/\(self.size)/\(repo.items.first!.path!)"
    }
}
