//
//  MainViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import UIKit

class MainViewController: UITabBarController {

    let notificationManager = NotificationManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let vc1 = SessionsTableViewController()
        let tabOne = SessionsNavViewController(rootViewController: vc1)
        
        let vc2 = MeNewTableViewController(style: .insetGrouped)
        let tabTow = UINavigationController(rootViewController: vc2)
        
        let vc3 = FindMapViewController()
        vc3.whatsNew = whatsNew(force: false)
        let tabThree = UINavigationController(rootViewController: vc3)
        
        let vc4 = InvitationsTableViewController()
        let tabFour = UINavigationController(rootViewController: vc4)
        
        let tabOneBarItem = UITabBarItem(title: "main.tab.session".localized, image: UIImage(systemName: "person.2.wave.2.fill"), tag: 0)
        
        let tabTowBarItem = UITabBarItem(title: "main.tab.me".localized, image: UIImage(systemName: "person.fill"), tag: 1)
        
        let tabThreeBarItem = UITabBarItem(title: "main.tab.find".localized, image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let tabFourBarItem = UITabBarItem(title: "main.tab.invitation".localized, image: UIImage(systemName: "bell.fill"), tag: 3)
                
        tabOne.tabBarItem = tabOneBarItem
        tabTow.tabBarItem = tabTowBarItem
        tabThree.tabBarItem = tabThreeBarItem
        tabFour.tabBarItem = tabFourBarItem
        
        self.viewControllers = [tabThree, tabOne, tabTow, tabFour]
    }
    
    

}
