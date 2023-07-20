//
//  MainViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import UIKit
import FirebaseAuth

class MainViewController: UITabBarController, UITabBarControllerDelegate {

//    let notificationManager = NotificationManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        
        Auth.auth().signIn(withEmail: "test@mail.com", password: "tested")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let vc1 = MainTableViewController()
        let tab1 = UINavigationController(rootViewController: vc1)
        tab1.navigationBar.prefersLargeTitles = true
        
        let tabOneBarItem = UITabBarItem(title: "main.tab.session".localized, image: UIImage(systemName: "calendar"), tag: 0)
        
        let vc2 = MeTableViewController(style: .insetGrouped)
        let tab2 = UINavigationController(rootViewController: vc2)
        tab2.navigationBar.prefersLargeTitles = true
        let tabTowBarItem = UITabBarItem(title: "main.tab.me".localized, image: UIImage(systemName: "person.fill"), tag: 1)
        
        
        let vc3 = FindMapViewController()
        let tab3 = UINavigationController(rootViewController: vc3)
        tab3.navigationBar.prefersLargeTitles = true
        let tabThreeBarItem = UITabBarItem(title: "main.tab.find".localized, image: UIImage(systemName: "bus.fill"), tag: 2)
        
        
        tab1.tabBarItem = tabOneBarItem
        tab2.tabBarItem = tabTowBarItem
        tab3.tabBarItem = tabThreeBarItem
        
        self.viewControllers = [tab3, tab1, tab2]
    }
    
    

}
