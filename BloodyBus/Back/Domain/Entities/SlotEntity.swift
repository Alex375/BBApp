//
//  SlotEntity.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import Firebase


class SlotEntity
{
    public var startTime: Timestamp
    public var endTime: Timestamp
    public var service: Int
    public var userRef: DocumentReference?
    public var bench: Int
    
    init(startTime: Timestamp, endTime: Timestamp, service: Int, userRef: DocumentReference? = nil, bench: Int) {
        self.startTime = startTime
        self.endTime = endTime
        self.service = service
        self.userRef = userRef
        self.bench = bench
    }
    
    init(slot: SlotModel)
    {
        self.startTime = slot.startTime
        self.endTime = slot.endTime
        self.service = slot.service
        self.userRef = slot.userRef
        self.bench = slot.bench
    }
    
    
    func toModel() -> SlotModel
    {
        return SlotModel(startTime: self.startTime, endTime: self.endTime, service: self.service, userRef: self.userRef, bench: self.bench)
    }
    
    static func toModel(slots: [SlotEntity]) -> [SlotModel]
    {
        var res: [SlotModel] = []
        slots.forEach({res.append($0.toModel())})
        return res
    }
    
    static func toEntity(slots: [SlotModel]) -> [SlotEntity]
    {
        var res: [SlotEntity] = []
        slots.forEach({res.append(SlotEntity(slot: $0))})
        return res
    }
}
