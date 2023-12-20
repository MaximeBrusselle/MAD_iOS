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
    var name: String
}

struct CoasterDetailSeatingType: Codable {
    var name: String
}

struct CoasterDetailModel: Codable {
    var name: String
}

struct CoasterDetailManufacturer: Codable {
    var name: String
}

struct CoasterDetailRestraintType: Codable {
    var name: String
}

struct CoasterDetailLaunch: Codable {
    var name: String
}

struct CoasterDetailPark: Codable {
    var name: String
    var country: CoasterDetailCountry
}

struct CoasterDetailCountry: Codable {
    var name: String
}

struct CoasterDetailStatus: Codable {
    var name: String
}

struct CoasterDetailImage: Codable {
    var path: String
}
