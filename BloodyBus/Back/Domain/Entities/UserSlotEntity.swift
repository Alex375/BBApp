//
//  UserSlotEntity.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import Foundation
import FirebaseFirestore

class UserSlotEntity
{
    public var startTime: Timestamp
    public var endTime: Timestamp
    public var sessionRef: DocumentReference
    public var slotIndex: Int
    public var service: Int
        
    
    init(userSlot: UserSlotModel) {
        self.startTime = userSlot.startTime
        self.endTime = userSlot.endTime
        self.sessionRef = userSlot.sessionRef
        self.slotIndex = userSlot.slotIndex
        self.service = userSlot.service
    }
    
    func toModel() -> UserSlotModel
    {
        return UserSlotModel(startTime: self.startTime, endTime: self.endTime, sessionRef: self.sessionRef, slotIndex: self.slotIndex, service: self.service)
    }
    
    static func toModel(userSlots: [UserSlotEntity]) -> [UserSlotModel]
    {
        var res: [UserSlotModel] = []
        userSlots.forEach({res.append($0.toModel())})
        return res
    }
    
    static func toEntity(userSlots: [UserSlotModel]) -> [UserSlotEntity]
    {
        var res: [UserSlotEntity] = []
        userSlots.forEach({res.append(UserSlotEntity(userSlot: $0))})
        return res
    }
}
