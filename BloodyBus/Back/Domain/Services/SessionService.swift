//
//  SessionService.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import Firebase

func getSessionEntity(completion: @escaping (SessionEntity?, Error?) -> Void, sessionRef: DocumentReference)
{
    getSessionModel(completion: { sessionModel, id, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let sessionModel = sessionModel else {
            completion(nil, SessionRepositoryError.GetSessionFailed)
            return
        }
        guard let id = id else {
            completion(nil, SessionRepositoryError.GetSessionFailed)
            return
        }
        
        let sessionEntity = SessionEntity(session: sessionModel, id: id)
        
        completion(sessionEntity, nil)
        
    }, session: sessionRef)
}


func getAvailableSlots(session: SessionEntity, service: Int?) -> [SlotEntity]
{
    var res: [SlotEntity] = Array(session.slots)
    
    res = res.filter({$0.userRef == nil})
    
    if let service = service {
        res = res.filter({$0.service == service})
    }
    return res
}
