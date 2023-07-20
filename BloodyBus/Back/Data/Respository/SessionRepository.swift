//
//  SessionRepository.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import Firebase
import CoreLocation
import GeoFireUtils

func getSessionModel(completion: @escaping (SessionModel?, String?, Error?) -> Void, session: DocumentReference)
{
    session.getDocument { snapchot, error in
        if let err = error {
            completion(nil, nil, err)
            return
        }
        guard let document = snapchot else {
            completion(nil, nil, SessionRepositoryError.GetSessionFailed)
            return
        }
        
        let result = Result {
            try document.data(as: SessionModel.self)
        }
        switch result {
            case .success(let success):
            completion(success, document.documentID, nil)
        case .failure(let failure):
            completion(nil, nil, failure)
        }
    }
}

func getSessionRef(sessionID: String) -> DocumentReference
{
    let db = Firestore.firestore()
    return db.collection("sessions").document(sessionID)
}



func getSessionAround(center: CLLocationCoordinate2D, radius: Double, sport: Int, privacy: Bool, completion: @escaping([(SessionModel, String)], Error?) -> Void)
{
    let queryBound = GFUtils.queryBounds(forLocation: center, withRadius: radius)
    
    let db = Firestore.firestore()
    
//    let now = Timestamp(date: Date.now)
    
    let query = queryBound.compactMap({ bound -> Query in
        return db.collection("sessions")
            .order(by: "location.geohash")
            .start(at: [bound.startValue])
            .end(at: [bound.endValue])
    })
    
    
    var res:[(SessionModel, String)] = []

    
    for q in query
    {
        q.getDocuments { snapchot, error in
            if let error = error
            {
                completion([], error)
                return
            }
            guard let documents = snapchot?.documents else {
                completion([], SessionRepositoryError.NearSessionError)
                return
            }

            
            for doc in documents
            {
                let result = Result {
                    try doc.data(as: SessionModel.self)
                }
                switch result {
                case .success(let success):
                    res.append((success, doc.documentID))
                case .failure(let failure):
                    completion([], failure)
                }
            }
            completion(res, nil)
        }
    }
}
