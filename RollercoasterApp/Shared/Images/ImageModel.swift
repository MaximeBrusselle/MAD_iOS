//
//  ImageModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 21/12/2023.
//

import Foundation

struct CoasterImage: Codable {
    var coaster: String?
    var credit: String?
    var path: String?
}

struct ImageRepo: Codable {
    var items: [CoasterImage]
    var amount: Int?

    enum CodingKeys: String, CodingKey {
        case items = "hydra:member"
        case amount = "hydra:totalItems"
    }
}
