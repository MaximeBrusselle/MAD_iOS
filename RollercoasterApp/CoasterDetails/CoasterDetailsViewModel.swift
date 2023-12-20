//
//  CoasterDetailsViewController.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation
import Alamofire
import Combine

class CoasterDetailsViewModel: ObservableObject {
    var id: Int
    init(id: Int){
        self.id = id
        fetchCoasters(id)
    }
    @Published var coaster = CoasterDetail()
    
    func fetchCoasters(_ id: Int){
        let apiKey = PlistReader().getPlistProperty(withName: "keys", withValue: "CaptainCoasterApiKey")
        if apiKey == nil {
            return
        }
        let url = "https://www.captaincoaster.com/api/coasters/\(self.id)"
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        guard let url = URL(string: url) else {
            return
        }
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            if(response.response?.statusCode == 404){
                print("404")
                return
            }
            guard let data = response.data else {
                return
            }
            
            do {
                let res = try JSONDecoder().decode(CoasterDetail.self, from: data)
                self.coaster = res
            } catch {
                print(error)
            }
        }
    }
}
