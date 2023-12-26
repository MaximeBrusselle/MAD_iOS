//
//  CoasterDetails.swift
//  RollercoasterApp
//
//  Created by Maxime Brusselle on 20/12/2023.
//
import Foundation

struct CoasterDetail: Codable {
    var id: Int?
    var name: String?
    var materialType: CoasterDetailMaterialType?
    var seatingType: CoasterDetailSeatingType?
    var model: CoasterDetailModel?
    var speed: Int?
    var height: Int?
    var length: Int?
    var inversionsNumber: Int?
    var manufacturer: CoasterDetailManufacturer?
    var restraint: CoasterDetailRestraintType?
    var launchs: [CoasterDetailLaunch]?
    var park: CoasterDetailPark?
    var status: CoasterDetailStatus?
    var openingDate: String?
    var closingDate: String?
    var mainImage: CoasterDetailImage?
}

struct CoasterDetailMaterialType: Codable {
    var name: String?
}

struct CoasterDetailSeatingType: Codable {
    var name: String?
}

struct CoasterDetailModel: Codable {
    var name: String?
}

struct CoasterDetailManufacturer: Codable {
    var name: String?
}

struct CoasterDetailRestraintType: Codable {
    var name: String?
}

struct CoasterDetailLaunch: Codable {
    var name: String?
}

struct CoasterDetailPark: Codable {
    var name: String?
    var country: CoasterDetailCountry?
}

struct CoasterDetailCountry: Codable {
    var name: String?
}

struct CoasterDetailStatus: Codable {
    var name: String?
}

struct CoasterDetailImage: Codable {
    var path: String?
}

extension CoasterDetail {
    func getProperty(property str: String?, start: String = "") -> String {
        guard let prop = str else {
            return "Unknown"
        }
        
        guard prop.contains("."), !start.isEmpty else {
            return prop
        }
        
        let components = prop
            .replacingOccurrences(of: start, with: "")
            .components(separatedBy: ".")

        let cleanedString = components
            .enumerated()
            .map { $0.offset == 0 ? $0.element.capitalized : $0.element }
            .joined(separator: " ")

        return cleanedString
    }

    func convertToDate(from date: String) -> String {
        //todo fix
        guard date != "Unknown" else {
            return "Unknown"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
       
        guard let date = dateFormatter.date(from: date) else {
            return "Unknown"
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateStyle = .short
       
        let formattedDate = outputDateFormatter.string(from: date)
        return formattedDate
    }
}
