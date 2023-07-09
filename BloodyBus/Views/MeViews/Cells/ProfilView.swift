//
//  ProfilView.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 07/07/2023.
//

import UIKit

class ProfilView: UIView {

    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.fill")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-HeavyItalic", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var mailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "System", size: 14)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(named: "AccentColor")
        return lbl
    }()
    
    var name: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var mail: String? {
        get {
            return mailLabel.text
        }
        set {
            mailLabel.text = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        layoutImage()
        layoutLabels()
        
        
    }
    
    private func layoutImage()
    {
        let imageContainer = UIView()
        imageContainer.backgroundColor = .gray
        imageContainer.addSubview(imageView)
        
        imageView.anchor(
            top: imageContainer.topAnchor,
            leading: imageContainer.leadingAnchor,
            bottom: imageContainer.bottomAnchor,
            trailing: imageContainer.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        addSubview(imageContainer)
        imageContainer.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            trailing: nil,
            padding: .init(top: 20, left: 20, bottom: 20, right: 0))
        imageContainer.widthAnchor.constraint(equalTo: imageContainer.heightAnchor).isActive = true
        imageContainer.layer.cornerRadius = 45
        imageContainer.clipsToBounds = true
    }
    
    private func layoutLabels()
    {
        let labelStack = stack(.vertical, views: nameLabel, mailLabel, spacing: 3)
        
        labelStack.anchor(
            top: nil,
            leading: imageView.trailingAnchor,
            bottom: nil,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 0, left: 40, bottom: 0, right: 10))
        
        labelStack.centerInSuperview(centerType: .centerY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

