//
//  SessionEntity.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import Firebase


class SessionEntity

{
    // MARK: - Id
    var id: String
    
    // MARK: - Attributs
    var startTime: Timestamp
    var endTime: Timestamp
    var location: GeoPointEntity
    var busRef: String
    var slots: [SlotEntity]
    
    init(id: String, startTime: Timestamp, endTime: Timestamp, location: GeoPointEntity, busRef: String, slots: [SlotEntity]) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.busRef = busRef
        self.slots = slots
    }
    
    init(session: SessionModel, id: String)
    {
        self.id = id
        self.startTime = session.startTime
        self.endTime = session.endTime
        self.location = GeoPointEntity(geoPoint: session.location)
        self.busRef = session.busRef
        self.slots = SlotEntity.toEntity(slots: session.slots)
    }
    
    func toModel() -> SessionModel
    {
        return SessionModel(
            startTime: self.startTime,
            endTime: self.endTime,
            location: self.location.toModel(),
            busRef: self.busRef,
            slots: SlotEntity.toModel(slots: self.slots)
        )
    }
}
