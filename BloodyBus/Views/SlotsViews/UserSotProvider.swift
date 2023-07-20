//
//  UserSotProvider.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import Foundation

class UserSlotProvider
{
    enum Sections: Int, CaseIterable, CustomStringConvertible
    {
        case soon
        case upcoming
        case passed
        var description: String
        {
            switch self
            {
            case .soon: return "slot.tv.section.soon.title".localized
            case .upcoming: return "slot.tv.section.upcoming.title".localized
            case .passed: return "slot.tv.section.passed.title".localized
            }
        }
    }
    private var _passed: [UserSlotEntity] = []
    private var _upcoming: [UserSlotEntity] = []
    private var _soon: [UserSlotEntity] = []
    private var _sectionMap: [UserSlotProvider.Sections] = []
    var passed: [UserSlotEntity] {
        get {
            return _passed
        }
    }
    
    var upcoming: [UserSlotEntity] {
        get {
            return _upcoming
        }
    }
    
    var soon: [UserSlotEntity] {
        get {
            return _soon
        }
    }
    
    func provideSlots(slots: [UserSlotEntity])
    {
        _upcoming.removeAll()
        _soon.removeAll()
        _passed.removeAll()
        _sectionMap = [.soon, .upcoming, .passed]
        let slots = slots.sorted { lhs, rhs in
            lhs.startTime.seconds > rhs.startTime.seconds
        }
        for slot in slots {
            if slot.startTime.dateValue() < Date.now
            {
                _passed.append(slot)
            }
            else if slot.startTime.dateValue() < Date.now.dayAfter
            {
                _soon.append(slot)
            }
            else
            {
                _upcoming.append(slot)
            }
        }
        if _soon.isEmpty
        {
            _sectionMap.remove(at: _sectionMap.firstIndex(of: .soon)!)
        }
        if _upcoming.isEmpty
        {
            _sectionMap.remove(at: _sectionMap.firstIndex(of: .upcoming)!)
        }
        if _passed.isEmpty
        {
            _sectionMap.remove(at: _sectionMap.firstIndex(of: .passed)!)
        }
    }
    
    func getSectionType(forSection section: Int) -> UserSlotProvider.Sections
    {
        if _sectionMap.count <= section
        {
            return .passed
        }
        return _sectionMap[section]
    }
    
    func getSectionNumber() -> Int
    {
        return _sectionMap.count
    }
    
    func getRowNumber(for section: Int) -> Int
    {
        let sectionType = _sectionMap[section]
        switch sectionType
        {
        case .upcoming: return _upcoming.count
        case .soon: return _soon.count
        case .passed: return _passed.count
        }
    }
    
    func getSlot(at indexPath: IndexPath) -> UserSlotEntity
    {
        let sectionType = _sectionMap[indexPath.section]
        switch sectionType
        {
        case .passed: return _passed[indexPath.row]
        case .upcoming: return _upcoming[indexPath.row]
        case .soon: return _soon[indexPath.row]
        }
    }
    
}
