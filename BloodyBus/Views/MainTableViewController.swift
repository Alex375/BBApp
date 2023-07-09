//
//  MainTableViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import UIKit

class MainTableViewController: UITableViewController, UserManagerDelegate {

    // MARK: - Attributs
    var user: UserEntity? = nil
    let userUpdater: UserUpdater = UserUpdater()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "bus.title".localized
        
        userUpdater.delegate = self
        userUpdater.registerUserManagerDelegate()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    func userDidRecieveUpdate(updatedUser: UserEntity) {
        self.user = updatedUser
        tableView.reloadData()
    }
    
    // MARK: - Methods

    @objc func createResult()
    {
        if !UserManager.isUserConnected
        {
//            let vc = LoginViewController()
//            vc.isModalInPresentation = true
//            self.present(
//                LoginNavVCViewController(rootViewController: vc),
//                animated: true,
//                completion: nil)
            return
        }
        UserManager.getUser { user in
            self.user = user
            //self.provider.provideSession(sessions: user.userSessions)
            self.tableView.reloadData()
        } errorCompletion: { error in
            presentBasicAlert(on: self, title: "Error", message: error.localizedDescription)
        }
    }

}
