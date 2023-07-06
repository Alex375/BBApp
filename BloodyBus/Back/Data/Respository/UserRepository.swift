//
//  UserRepository.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

/**
 Get the current user model
 - Remark: Async exectution
 - Parameter completion: Completion when user model is catch paramter(*userModel*, *user model  ID*, *Error*)
 */
func getUserModel(completion: @escaping (UserModel?, String?, Error?) -> Void) {
    let db = Firestore.firestore()
    db.collection("users")
        .whereField("user-id", isEqualTo: Auth.auth().currentUser!.uid)
        .limit(to: 1)
        .getDocuments { snapchot, Error in
            if let err = Error
            {
                completion(nil, nil, err)
                return
            }
            if snapchot!.documents.isEmpty
            {
                completion(nil, nil, UserRepositoryError.GetUserFailed)
                return
            }
            let document = snapchot!.documents[0]
            let result = Result {
                try document.data(as: UserModel.self)
            }
            switch result {
            case .success(let success):
                completion(success, document.documentID, nil)
            case .failure(let failure):
                completion(nil, nil, failure)
                return
            }
        }
}
