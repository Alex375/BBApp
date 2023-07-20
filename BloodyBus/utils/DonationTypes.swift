//
//  DonationType.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import Foundation
import UIKit



/**
 Utility class for donation descritpion
 */
class Donation
{
    /**
        Array of availble donation.
     - Note: This array is compsed of localized string.
     */
    static let donations = ["donation.blood".localized,
                         "donation.plasma".localized,
                         "donation.palatet".localized
    ]
    static let iconIdentifers = ["heart.text.square.fill",
                                 "bolt.horizontal.circle.fill",
                                 "circle.lefthalf.fill"
                                ]
    
    /**
     Function that return a string coresponding to a given index
     - Parameter index: Given index for a donation.
     - Returns: A localized string coresponding to the given index.
     - Remark: If the index is out of bound it will return a localize unknown string
     */
    static func getDonation(with index: Int?) -> String
    {
        guard let index = index else {
            return "donation.unknown".localized
        }

        if index >= donations.count {
            return "donatrion.unknown".localized
        }
        return donations[index]
    }
    
    /**
     Function that return an icon identifier for a given donation
     - Parameter index: Given donation index
     - Returns: A string representing the identifer of the icon for the given donation
     - Remark: If the index is out of bound it will return a localize unknown string
     */
    static func iconIdentifier(forDonation index: Int?) -> String
    {
        guard let index = index else {
            return "questionmark"
        }

        if index >= donations.count {
            return "questionmark"
        }
        
        return iconIdentifers[index]
    }
    
    /**
     Function that return an icon for a given donation
     - Parameter index: Given donation index
     - Returns: A  representing representing the donation
     - Remark: If the index is out of bound it will return a question mark icon
     */
    static func icon(forDonation index: Int?) -> UIImage
    {
        return UIImage(systemName: iconIdentifier(forDonation: index)) ?? UIImage(systemName: "questionmark")!
    }
    
}
