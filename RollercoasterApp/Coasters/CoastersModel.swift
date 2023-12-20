//
//  CoastersModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation

struct Coaster: Codable {
    var id: Int
    var name: String
    var park: CoastersPark
    var status: CoastersStatus
    var rank: Int?
}

struct CoastersPark: Codable {
    var name: String
}

struct CoastersStatus: Codable {
    var name: String
}

struct CoastersRepo: Codable {
    var hydraMember: [Coaster]

    enum CodingKeys: String, CodingKey {
        case hydraMember = "hydra:member"
    }
}
