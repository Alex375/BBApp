//
//  StringExtension.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation


extension String
{
    /**
     Function that return the localized string.
     - Returns: The localized string of self.
     - Remark: If User default for debugdstring is true it will return self.
     */
    func localizeString() -> String
    {
        if UserPreference.preference(forSetting: .debugStringSetting) {
            return self
        }
        return NSLocalizedString(self, comment: "")
            
    }
    
    /**
     Localized version of string.
     - Remark: If User default for debugdstring is true `localized` = self
     */
    var localized: String { self.localizeString() }
}

