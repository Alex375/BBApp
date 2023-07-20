//
//  MainTableViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import UIKit
import FirebaseFirestore

class MainTableViewController: UITableViewController, UserManagerDelegate {

    // MARK: - Attributs
    var user: UserEntity? = nil
    let provider = UserSlotProvider()
    let userUpdater: UserUpdater = UserUpdater()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "slots.title".localized
        
        userUpdater.delegate = self
        userUpdater.registerUserManagerDelegate()
        
        tableView.register(SlotTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 85
        
        createResult() // Populating table view
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return provider.getSectionNumber()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.getRowNumber(for: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return provider.getSectionType(forSection: section).description
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! SlotTableViewCell

        // Configure the cell...

        let slot = provider.getSlot(at: indexPath)
        cell.slotView.nameLabel.text = Donation.getDonation(with: slot.service)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE, dd MMM HH:mm"
        let date = slot.startTime.dateValue()
        let dateFormated = dateFormatter.string(from: date)
        cell.slotView.dateLabel.text = dateFormated
        if provider.getSectionType(forSection: indexPath.section) == UserSlotProvider.Sections.soon
        {
            cell.slotView.setState(state: .Highlight)
        }
        else
        {
            cell.slotView.setState(state: .Default)
        }
        
        cell.slotView.donationImage.imageView.image = Donation.icon(forDonation: slot.service)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = user else {
            return
        }
        let userSlot = provider.getSlot(at: indexPath)
        
        getSessionEntity(completion: { session, error in
            if let error = error {
                print(error)
                return
            }
            guard let session = session else {
                return
            }
            let slot = session.slots[userSlot.slotIndex]
            let vc = DetailSlotViewController()
            vc.user = self.user
            vc.userSlot = userSlot
            vc.slot = slot
            vc.session = session
            self.navigationController?.pushViewController(vc, animated: true)
        }, sessionRef: userSlot.sessionRef)
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
            self.provider.provideSlots(slots: user.slots)
            self.tableView.reloadData()
        } errorCompletion: { error in
            presentBasicAlert(on: self, title: "Error", message: error.localizedDescription)
        }
    }
    
    // MARK: - User manager delegate
    
    func userDidRecieveUpdate(updatedUser: UserEntity) {
        self.user = updatedUser
        self.provider.provideSlots(slots: updatedUser.slots)
        tableView.reloadData()
    }

}
