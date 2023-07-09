//
//  GeoPointEntity.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import CoreLocation

class GeoPointEntity
{
    var geoPoint: GeoPoint
    var geoHash: String
    
    init(geoPoint: GeoPoint, geoHash: String)
    {
        self.geoPoint = geoPoint
        self.geoHash = geoHash
    }
    
    init(geoPoint: GeoPointModel)
    {
        self.geoPoint = geoPoint.geoPoint
        self.geoHash = geoPoint.geoHash
    }
    
    func toModel() -> GeoPointModel
    {
        return GeoPointModel(geoPoint: geoPoint, geoHash: geoHash)
    }
    
    func toCoordinate() -> CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
    }
}

