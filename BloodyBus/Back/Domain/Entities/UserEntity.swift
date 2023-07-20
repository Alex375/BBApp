//
//  UserEntity.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation
import FirebaseFirestore


/**
 User entiy (high level class for user)
 - Parameter id:
 */
class UserEntity
{
    public let id: String
    public var userName: String
    public var userId: String
    public var birthDate: Timestamp
    public var slots: [UserSlotEntity]
    
    
    init(user: UserModel, id: String) {
        self.id = id
        self.userName = user.userName
        self.userId = user.userId
        self.birthDate = user.birthDate
        self.slots = UserSlotEntity.toEntity(userSlots: user.slots)
    }
    
    init(userName: String) {
        self.id = ""
        self.userName = userName
        self.userId = ""
        self.birthDate = Timestamp()
        self.slots = []
    }
    
    func toModel() -> UserModel
    {
        return UserModel(
            userName: self.userName,
            userId: self.userId,
            birthDate: self.birthDate,
            slots: UserSlotEntity.toModel(userSlots: self.slots)
        )
    }
}
