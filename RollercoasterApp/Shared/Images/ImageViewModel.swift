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
    @Published var repo: ImageRepo = .init(hydraMember: [])
    @Published var imageURL = ""
    @Published var isDataLoaded = false 
    
    init(id: Int, size: String) {
        self.id = id
        self.size = size
        fetchImage(coaster: 1)
    }
    

    
    func fetchImage(coaster id: Int){
        let apiKey = PlistReader().getPlistProperty(withName: "keys", withValue: "CaptainCoasterApiKey")
        if apiKey == nil {
            return
        }
        let url = "https://captaincoaster.com/api/images?page=1&coaster=1"
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        guard let url = URL(string: url) else {
            return
        }
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: ImageRepo.self) { response in
            if(response.response?.statusCode == 404){
                print("404")
                return
            }
            guard let data = response.data else {
                return
            }
            
            do {
                let res = try JSONDecoder().decode(ImageRepo.self, from: data)
                self.repo = res
                self.imageURL = self.getImageUrl(size: self.size)
                self.isDataLoaded = true
                debugPrint(self.imageURL)
                
            } catch {
                print(error)
            }
        }
    }
    
    func getImageUrl(size: String) -> String {
        let first = repo.hydraMember.first
        
        if first != nil {
            return "https://pictures.captaincoaster.com/\(size)/\(first!.path!)"
        }
        
        return "https://ik.imagekit.io/demo/medium_cafe_B1iTdD0C.jpg"
    }
}
