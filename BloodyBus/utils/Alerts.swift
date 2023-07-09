//
//  Alerts.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import UIKit

func presentBasicAlert(on viewController: UIViewController, title: String, message: String)
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    viewController.present(alert, animated: true)
}
