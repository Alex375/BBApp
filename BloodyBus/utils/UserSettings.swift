//
//  UserSettings.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation

enum SettingConstant: CustomStringConvertible
{
    case debugStringSetting
    case advanceAnalyticsSetting
    case devloperMode
    
    var description: String {
        switch self {
        case .debugStringSetting:
            return "debug-string"
        case .advanceAnalyticsSetting:
            return "advance-analytic"
        case .devloperMode:
            return "devloper_preference"
        }
    }
    
    
}

class UserPreference
{
    
    static func preference(forSetting setting: SettingConstant) -> Bool
    {
        return UserDefaults.standard.bool(forKey: setting.description)
    }
    
    static func setPrefrence(to: Bool, forSettig setting: SettingConstant)
    {
        UserDefaults.standard.set(to, forKey: setting.description)
    }
}

