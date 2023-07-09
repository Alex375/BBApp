//
//  UserModels.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation


import Foundation
import Firebase

public struct UserModel: Codable
{
    let userName: String
    let userId: String
    let birthDate: Timestamp
    
    enum CodingKeys: String, CodingKey
    {
        case userName = "user-name"
        case userId = "user-id"
        case birthDate = "birth-date"
    }
}
