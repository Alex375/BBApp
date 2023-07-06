//
//  Login+RegisterService.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseAnalytics

func login(mail: String, password: String, completion: @escaping(UserEntity?, Error?) -> Void)
{
    Auth.auth().signIn(withEmail: mail, password: password) { result, error in

        if let error = error {
            completion(nil, error)
            return
        }

        guard let _ = result else { return }
        getUserEntity { user, error in
            if let err = error {
                completion(nil, err)
                return
            }
            guard let _ = user else { return }
            if UserPreference.preference(forSetting: .advanceAnalyticsSetting)
            {
                Analytics.logEvent(AnalyticsEventLogin, parameters: [:])
            }
            completion(user, nil)
        }

    }
}
