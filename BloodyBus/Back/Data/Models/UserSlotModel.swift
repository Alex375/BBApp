//
//  UserSlotModel.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import Foundation
import FirebaseFirestore


public struct UserSlotModel: Codable
{
    let startTime: Timestamp
    let endTime: Timestamp
    let sessionRef: DocumentReference
    let slotIndex: Int
    let service: Int
    
    enum CodingKeys: String, CodingKey
    {
        case startTime = "start-time"
        case endTime = "end-time"
        case sessionRef = "session-ref"
        case slotIndex = "slot-index"
        case service
    }
    
    func toDict() -> Dictionary<String, Any?>
    {
        return [
            "start-time": self.startTime,
            "end-time": self.endTime,
            "session-ref": self.sessionRef,
            "slot-index": self.slotIndex,
            "serice": self.service
        ]
    }
}
