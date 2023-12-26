//
//  CoastersViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation
import Combine

class CoastersViewModel: ObservableObject {
    @Published var repo: CoastersRepo = .init(items: [], total: nil)
    @Published var doneFetching = false
    @Published var errorMessage = ""
    @Published var isOnFirstPage = true
    @Published var hasNextPage = true
    private var page = 1
    private var searchTerm = ""
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchCoasters() {
        let url = URL(string: "https://captaincoaster.com/api/coasters?page=\(self.page)&name=\(self.searchTerm)")!
        
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
            .decode(type: CoastersRepo.self, decoder: JSONDecoder())
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
            }, receiveValue: { [weak self] repo in
                guard let self = self else { return }
                self.repo = repo
                if repo.total! < 30*page {
                    hasNextPage = false
                } else {
                    hasNextPage = true
                }
                self.doneFetching = true
            })
            .store(in: &cancellables)
    }
    
    func fetchNextCoasters() {
        self.page += 1
        self.isOnFirstPage = false
        self.doneFetching = false
        fetchCoasters()
    }
    
    func fetchPrevCoasters() {
        guard page > 1 else {
            return
        }
        self.page -= 1
        self.doneFetching = false
        if page == 1 {
            self.isOnFirstPage = true
        }
        fetchCoasters()
    }
    
    func searchCoasters(searchTerm: String) {
        self.page = 1
        self.doneFetching = false
        self.isOnFirstPage = true
        self.searchTerm = searchTerm
        fetchCoasters()
    }
    
    
}
