//
//  SessionRepository.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 09/07/2023.
//

import Foundation
import Firebase

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
