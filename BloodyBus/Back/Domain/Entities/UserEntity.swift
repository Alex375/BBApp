//
//  UserEntity.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation


/**
 User entiy (high level class for user)
 - Parameter id:
 */
class UserEntity
{
    public let id: String
    public var userName: String
    public var userId: String
    
    init(user: UserModel, id: String) {
        self.id = id
        self.userName = user.userName
        self.userId = user.userId
    }
    
    init(userName: String) {
        self.id = ""
        self.userName = userName
        self.userId = ""
    }
    
    func toModel() -> UserModel
    {
        return UserModel(
            userName: self.userName,
            userId: self.userId)
    }
}
