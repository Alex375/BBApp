//
//  Errors.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation

enum UserRepositoryError: Error, LocalizedError
{
    case GetUserSessionFailed
    case DeletionFailed
    case CreateUserFailed
    case CreateUserSessionFailed
    case UserNameCheckFailed
    case UserNameAlreadyUsed
    case GetUserFailed
    case NoUserWithUserName
    var errorDescription: String? {
        get {
            switch self
            {
            case .GetUserSessionFailed: return "Couldn't get user session because document was nul.".localized
            case .DeletionFailed: return "Deletion failed".localized
            case .CreateUserFailed: return "Couldn't create user because document was nul.".localized
            case .CreateUserSessionFailed: return "Couldn't create user session because document was nul.".localized
            case .UserNameCheckFailed: return "Couldn't acces database to check user name.".localized
            case .UserNameAlreadyUsed: return "The user name is already used."
            case .GetUserFailed: return "Couldn't get user."
            case .NoUserWithUserName: return "No user coresponding to that user name."
            }
        }
    }
}

enum SessionRepositoryError: Error, LocalizedError
{
    case GetSessionFailed
    case GetTeamFailed
    case GetPersonFailed
    case CreateSessionFailed
    case CreatePersonFailed
    case NearSessionError
    case CreateTeamError
    var errorDescription: String? {
        get {
            switch self
            {
            case .GetSessionFailed: return "Couldn't load session because the document was null.".localized
            case .GetTeamFailed: return "Couldn't load teams because the document was null.".localized
            case .GetPersonFailed: return "Couldn't load participants because the document was null.".localized
            case .CreateSessionFailed: return "Couldn't create session because the document was null.".localized
            case .CreatePersonFailed: return "Couldn't create person because the document was null.".localized
            case .NearSessionError: return "Failed to get near sessions.".localized
            case .CreateTeamError: return "Couldn't create team because an error occured.".localized
            }
        }
    }
}

enum SessionServiceError: Error, LocalizedError
{
    case JoinSessioError
    case JoinUserAlreadyInSession
    case JoinSessionFull
    case CreateSessionError
    case DeleteSessionError
    case LeaveSessionError
    var errorDescription: String?
    {
        get {
            switch self
            {
            case .JoinSessioError: return "Couldn't join the session because an error occured.".localized
            case .JoinUserAlreadyInSession: return "Couldn't join session because user is already in the session.".localized
            case .JoinSessionFull: return "Couldn't join session beacause the session is full.".localized
            case .CreateSessionError: return "Couldn't create session because an error occured.".localized
            case .DeleteSessionError: return "Couldn't delete session because an error occured.".localized
            case .LeaveSessionError: return "Couldn't leave session because an error occured.".localized
            }
        }
    }
}

enum UserServiceError: Error, LocalizedError
{
    case CreateUserError
    case RegisterError
    var errorDescription: String?
    {
        get {
            switch self {
            case .CreateUserError: return "Couldn't create user because an error occured.".localized
            case .RegisterError: return "Couldn't register because an error occured.".localized
            }
        }
    }
}
