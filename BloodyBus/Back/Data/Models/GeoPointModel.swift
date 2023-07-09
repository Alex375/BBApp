//
//  GeoPointModel.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct GeoPointModel: Codable
{
    let geoPoint: GeoPoint
    let geoHash: String
    
    enum CodingKeys: String, CodingKey
    {
        case geoPoint = "geopoint"
        case geoHash = "geohash"
    }
}

