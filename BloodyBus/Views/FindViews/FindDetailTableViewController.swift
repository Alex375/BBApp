//
//  FindDetailTableViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 11/07/2023.
//

import UIKit

class FindDetailTableViewController: UITableViewController {

    // MARK: - Attributs
    var user: UserEntity?
    var session: SessionEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DonationTypeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 85
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let session = session
        {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "EEEE, dd MMM HH:mm"
            let date = session.startTime.dateValue()
            let dateFormated = dateFormatter.string(from: date)
            self.title = dateFormated
        }
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.session?.services.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DonationTypeTableViewCell

        // Configure the cell...
        cell.donationView.nameLabel.text = Donation.getDonation(with: session?.services[indexPath.row])
        cell.donationView.donationImage.imageView.image = Donation.icon(forDonation: session?.services[indexPath.row])
        cell.donationView.timeLabel.text = "2h"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SlotChoosingTableViewController(style: .insetGrouped)
        vc.session = self.session
        vc.user = user
        vc.service = session?.services[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
