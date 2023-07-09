//
//  MeTableViewProvider.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 07/07/2023.
//

import Foundation
import UIKit

protocol MeProviderSectionType: CustomStringConvertible {
    var rowType: MeProvider.RowType { get }
    var rowHeight: CGFloat { get }
}


class MeProvider
{
    enum RowType: Int
    {
        case Default = 1
        case Profil = 2
        case Stats = 3
        
        var identifier: String {
            switch self {
            case .Default: return "default-cell"
            case .Profil: return "profil-cell"
            case .Stats: return "stat-cell"
            }
        }
    }
    
    enum Section: Int, CaseIterable, CustomStringConvertible
    {
        case Profil
        case Account
        case Devlopper
        
        var description: String {
            switch self {
            case .Profil: return ""
            case .Account: return "me.section.account".localized
            case .Devlopper: return "Devlopper"
            }
        }
    }
    
    enum ProfilSection: Int, CaseIterable, MeProviderSectionType
    {
        var description: String {
            return ""
        }
        
        case Profil
        case Stat
        
        var rowType: MeProvider.RowType {
            switch self {
            case .Profil: return .Profil
            case .Stat: return .Stats
            }
        }
        
        var rowHeight: CGFloat {
            switch self {
            case .Profil:
                return 130
            case .Stat:
                return 90
            }
        }
    }
    
    enum AccountSection: Int, CaseIterable, MeProviderSectionType
    {
        case Account
        
        var rowType: MeProvider.RowType {
            return .Default
        }
        
        var rowHeight: CGFloat {
            return 40
        }
        
        var description: String {
            return "me.row.account".localized
        }
    }
    
    
    enum Devlopper: Int, CaseIterable, MeProviderSectionType
    {
        case Devlopper
        
        var rowType: MeProvider.RowType {
            return .Default
        }
        
        var rowHeight: CGFloat {
            return 40
        }
        
        var description: String {
            return "Devlopper settings"
        }
    }
    
    static func cellForRow(for section: MeProvider.Section, at indexPath: IndexPath, cell: UITableViewCell, target: MeTableViewController) -> UITableViewCell
    {
        switch section {
        case .Profil:
            let row = ProfilSection(rawValue: indexPath.row)
            switch row {
            case .Profil:
                let cell = cell as! ProfilTableViewCell
                cell.profilView.name = target.user?.userName
                if UserManager.isUserConnected {
                    cell.profilView.mail = UserManager.currentUser?.email
                }
                return cell
            case .Stat:
                let cell = cell as! StatsTableViewCell
                cell.statView.sessions = "0"
                
                guard let date = target.user?.birthDate.dateValue() else {
                    cell.statView.birth = "Unknown"
                    return cell
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "dd MMM YYYY"
                let dateFormated = dateFormatter.string(from: date)
                cell.statView.birth = dateFormated
                return cell
            case .none:
                 return cell
            }
            
        case .Account:
            cell.imageView?.image = UIImage(systemName: "person")
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "me.row.account".localized
            return cell
        case .Devlopper:
            cell.imageView?.image = UIImage(systemName: "hammer")
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Devlopper settings"
            return cell
        }
    }
    
    static func didSelectARow(in section: MeProvider.Section, at indexPath: IndexPath, target: MeTableViewController)
    {
        switch section
        {
        case .Profil:
            break
        case .Account:
//            let vc = AccountSettingsTableViewController(style: .insetGrouped)
//            target.navigationController?.pushViewController(vc, animated: true)
            break
        case .Devlopper:
//            let vc = DevloperSettingsTableViewController(style: .insetGrouped)
//            target.navigationController?.pushViewController(vc, animated: true)
            break
        }
    }
}

