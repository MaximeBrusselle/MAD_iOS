//
//  PlistReader.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//

import Foundation

class PlistReader {
    func getPlistProperty(withName name: String, withValue key: String) -> String? {
        let plistPath = Bundle.main.path(forResource: name, ofType: "plist")
        
        if let plistData = FileManager.default.contents(atPath: plistPath ?? "") {
            do {
                // Deserialize the plist data into a dictionary
                if let plistDictionary = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any] {
                    
                    // Access the value for the key "Name"
                    if let value = plistDictionary[key] as? String {
                        return value
                    } else {
                        return nil
                    }
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}
