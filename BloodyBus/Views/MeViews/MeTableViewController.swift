//
//  MeTableViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import UIKit

class MeTableViewController: UITableViewController, UserManagerDelegate {

    
    // MARK: - Attributs
    let userUpdater = UserUpdater()
    var user: UserEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        userUpdater.delegate = self
        userUpdater.registerUserManagerDelegate()
        
        navigationItem.title = "me.title".localized
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MeProvider.RowType.Default.identifier)
        tableView.register(ProfilTableViewCell.self, forCellReuseIdentifier: MeProvider.RowType.Profil.identifier)
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: MeProvider.RowType.Stats.identifier)
        
        UserManager.getUser { user in
            self.user = user
            self.tableView.reloadData()
        } errorCompletion: { _ in}

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return MeProvider.Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = MeProvider.Section(rawValue: section)
        switch sectionType {
        case .Profil: return MeProvider.ProfilSection.allCases.count
        case .Account: return MeProvider.AccountSection.allCases.count
        case .Devlopper: return MeProvider.Devlopper.allCases.count
        default: return 0
        }
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = MeProvider.Section(rawValue: indexPath.section)
        switch sectionType {
        case .Profil: return MeProvider.ProfilSection(rawValue: indexPath.row)?.rowHeight ?? 0
        case .Account: return MeProvider.AccountSection(rawValue: indexPath.row)?.rowHeight ?? 0
        case .Devlopper: return MeProvider.Devlopper(rawValue: indexPath.row)?.rowHeight ?? 0
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MeProvider.Section(rawValue: section)?.description
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        
        let sectionType = MeProvider.Section(rawValue: indexPath.section)
        
        var id = MeProvider.RowType.Default.identifier
        
        switch sectionType {
        case .Profil: id = MeProvider.ProfilSection(rawValue: indexPath.row)?.rowType.identifier ?? MeProvider.RowType.Default.identifier
        case .Account: id = MeProvider.AccountSection(rawValue: indexPath.row)?.rowType.identifier ?? MeProvider.RowType.Default.identifier
        case .Devlopper: id = MeProvider.Devlopper(rawValue: indexPath.row)?.rowType.identifier ?? MeProvider.RowType.Default.identifier
        default: break
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        return MeProvider.cellForRow(for: sectionType!, at: indexPath, cell: cell, target: self)
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = MeProvider.Section(rawValue: indexPath.section)!
        
        MeProvider.didSelectARow(in: section, at: indexPath, target: self)
    }
    
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if indexPath.section != 0 || indexPath.row != 0 {
            return nil
        }
        let action = UIAction(title: "Copy username", image: UIImage(systemName: "archivebox")) { action in
            UIPasteboard.general.string = self.user?.userName
        }
        let menu = UIMenu(title: "", children: [action])
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
            return menu
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - User manager delegate
    
    func userDidRecieveUpdate(updatedUser: UserEntity) {
        self.user = updatedUser
        self.tableView.reloadData()
    }

}
