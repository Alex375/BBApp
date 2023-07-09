//
//  UserManager.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//


import Foundation
import Firebase
import FirebaseAuth

enum UserMangerError: Error, LocalizedError
{
    case DoubleRegisterError(id: Int)
    case NoDelegate
    
    var errorDescription: String?
    {
        switch self {
        case .DoubleRegisterError(let id): return "Double callback registration on UserManagerDelegate, that's illegal. Already existing call back with id: \(id)"
        case .NoDelegate: return "User updater have no delegate."
        }
    }
}

protocol UserManagerDelegate
{
    /**
     This function is call when the user document is updated in the database
     - Parameter updatedUser: The updated `UserEntity` coresponding to the updated document
     */
    func userDidRecieveUpdate(updatedUser: UserEntity)
}

class UserUpdater
{
    private var id: Int?
    
    /**
     Delegate of the user updater
     */
    public var delegate: UserManagerDelegate?
    
    /**
     Register the user manager delegate to the user manger
     */
    func registerUserManagerDelegate()
    {
        if id != nil {
            fatalError(UserMangerError.DoubleRegisterError(id: id!).localizedDescription)
        }
        if delegate == nil {
            fatalError(UserMangerError.NoDelegate.localizedDescription)
        }
        id = UserManager.registerCallBack(call: delegate!.userDidRecieveUpdate)
    }
    
    /**
     Unregister the user manager delegate to the user manger
     */
    func unregisterUserManagerDelegate()
    {
        guard let id = id else {
            return
        }
        UserManager.userCallBacks.removeValue(forKey: id)
    }
    
    deinit {
        unregisterUserManagerDelegate()
    }
}


class UserManager
{
    
    static var user: UserEntity?
    static var listener: ListenerRegistration?
    
    static var userCallBacks: Dictionary<Int, (UserEntity) -> ()> = [:]
    static var currentId: Int = 0
    
    /**
        Descrip if the user is alive.
     
     True if the User manager user is not nil false else
     */
    static var isUserAlive: Bool {
        get {
            return user != nil
        }
    }
    
    /**
        Descrip if the user is alive.
     
     True if the Auth user is not nil false else
     */
    static var isUserConnected: Bool {
        get {
            return Auth.auth().currentUser != nil
        }
    }
    
    static var currentUser: User? {
        get {
            return Auth.auth().currentUser
        }
    }
    
    /**
     Get the user and listen user if not set aleready
     - Parameter completion: Completion to be called when user is get
     - Parameter errorCompletion: Completion to be called if an error occured
     
     - Note: If a user is already listened the former socket listener will be removed
     */
    static func getUser(completion: ((UserEntity) -> Void)?, errorCompletion: ((Error) -> Void)?)
    {
        var tCompletion = completion
        var tErrorCompletion = errorCompletion
        if !isUserConnected {
            return
        }
        let uid = Auth.auth().currentUser!.uid
        if !isUserAlive || uid != user!.userId
        {
            listener?.remove()
            let db = Firestore.firestore()
            listener = db.collection("users").whereField("user-id", isEqualTo: uid).limit(to: 1).addSnapshotListener { snapchot, error in
                if let error = error {
                    if let errorC = tErrorCompletion {
                        errorC(error)
                        tErrorCompletion = nil
                        tCompletion = nil
                    }
                    return
                }
                guard let documents = snapchot?.documents else {
                    if let errorC = tErrorCompletion {
                        errorC(UserRepositoryError.GetUserFailed)
                        tErrorCompletion = nil
                        tCompletion = nil
                    }
                    return
                }
                if documents.isEmpty {
                    if let errorC = tErrorCompletion {
                        errorC(UserRepositoryError.GetUserFailed)
                        tErrorCompletion = nil
                        tCompletion = nil
                    }
                    return
                }
                let result = Result {
                    try documents[0].data(as: UserModel.self)
                }
                switch result {
                case .success(let success):
                    let userEntity = UserEntity(user: success, id: documents[0].documentID)
                    if let comp = tCompletion {
                        comp(userEntity)
                        tErrorCompletion = nil
                        tCompletion = nil
                    }
                    for back in userCallBacks.values {
                        back(userEntity)
                    }
                    UserManager.user = userEntity
                case .failure(let failure):
                    if let errorC = tErrorCompletion {
                        errorC(failure)
                        tErrorCompletion = nil
                        tCompletion = nil
                    }
                    return
                }
            }
        }
        else
        {
            if let completion = completion {
                completion(user!)
            }
        }
    }
    
    /**
     Register a callback to the user manager
     - Parameter call: Call back to be register
     - Returns: The id of the callback for the user manager (*id to be used when refering to the call on the user maanger stand point*)
     */
    static func registerCallBack(call: @escaping(UserEntity) -> Void) -> Int
    {
        userCallBacks[currentId] = call
        currentId += 1
        return currentId - 1
    }
            
    
}

