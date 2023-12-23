//
//  CoastersModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation

struct Coaster: Codable, Identifiable {
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
    var items: [Coaster]

    enum CodingKeys: String, CodingKey {
        case items = "hydra:member"
    }
}

extension Coaster {
    func cleanedUpStatusString() -> String {
        let components = self.status.name
            .replacingOccurrences(of: "status.", with: "")
            .components(separatedBy: ".")

        let cleanedString = components
            .enumerated()
            .map { $0.offset == 0 ? $0.element.capitalized : $0.element }
            .joined(separator: " ")

        return cleanedString
    }
}
