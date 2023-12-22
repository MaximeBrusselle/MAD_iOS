//
//  CoastersViewModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation
import Alamofire

class CoastersViewModel: ObservableObject {
    init(){
        fetchCoasters()
    }
    @Published var repo: CoastersRepo = .init(hydraMember: [])
    
    func fetchCoasters(){
        let apiKey = PlistReader().getPlistProperty(withName: "keys", withValue: "CaptainCoasterApiKey")
        if apiKey == nil {
            return
        }
        let url = "https://www.captaincoaster.com/api/coasters"
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        guard let url = URL(string: url) else {
            return
        }
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CoastersRepo.self) { response in
            if(response.response?.statusCode == 404){
                print("404")
                return
            }
            guard let data = response.data else {
                return
            }
            
            do {
                let res = try JSONDecoder().decode(CoastersRepo.self, from: data)
                self.repo = res
            } catch {
                print(error)
            }
        }
    }
}
