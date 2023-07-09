//
//  SlotModel.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import Firebase

struct SlotModel: Codable
{
    let startTime: Timestamp
    let endTime: Timestamp
    let service: Int
    let userRef: DocumentReference?
    let bench: Int
    
    enum CodingKeys: String, CodingKey
    {
        case startTime = "start-time"
        case endTime = "end-time"
        case service
        case userRef = "user-ref"
        case bench
    }
}
