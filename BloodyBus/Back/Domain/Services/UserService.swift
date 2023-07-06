//
//  UserService.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation
import Firebase

func getUserEntity(completion: @escaping(UserEntity?, Error?) -> Void)
{
    getUserModel { user, id, error in
        if let err = error {
            completion(nil, err)
            return
        }
        
        let userEntity = UserEntity(user: user!, id: id!)
        
        completion(userEntity, nil)
        if UserPreference.preference(forSetting: .advanceAnalyticsSetting)
        {
            Analytics.logEvent("refresh_user", parameters: nil)
        }
        
//        getUserSession(completion: { sessions, error in
//            if let err = error {
//                completion(nil, err)
//                return
//            }
//            for session in sessions {
//                userEntity.userSessions.append(
//                    UserSessionEntity(session: session.0, id: session.1))
//            }
//
//        }, userId: userEntity.id)
        
    }
}
