//
//  SessionModel.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct SessionModel: Codable
{
    let startTime: Timestamp
    let endTime: Timestamp
    let location: GeoPointModel
    let busRef: String
    let slots: [SlotModel]
    
    enum CodingKeys: String, CodingKey
    {
        case startTime = "start-time"
        case endTime = "end-time"
        case location
        case busRef = "bus-ref"
        case slots
    }
    
}
