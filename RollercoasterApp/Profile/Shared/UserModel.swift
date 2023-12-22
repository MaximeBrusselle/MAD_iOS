//
//  UserModel.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 22/12/2023.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
