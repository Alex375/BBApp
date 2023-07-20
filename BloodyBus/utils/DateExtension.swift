//
//  DateExtension.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import Foundation

extension Date
{
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
