//
//  DetailInfoView.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 12/07/2023.
//


import UIKit

class DetailInfoView: UIView {

    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "AccentColor")
        return lbl
    }()
    
    lazy var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        return lbl
    }()
    
    lazy var disclosureIndicator: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .gray
        return iv
    }()
    
    var title: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var info: String? {
        get {
            return infoLabel.text
        }
        set {
            infoLabel.text = newValue
        }
    }
    
    var selectable: Bool {
        get {
            return !disclosureIndicator.isHidden
        }
        set {
            disclosureIndicator.isHidden = !newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        let stack1 = stack(.horizontal, views: infoLabel, disclosureIndicator, spacing: 0)
        
        let stack = stack(.vertical, views: nameLabel, stack1, spacing: 10)
        
        
        addSubview(nameLabel)
        nameLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil)
        
        addSubview(infoLabel)
        infoLabel.anchor(
            top: nameLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: nil,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        let disclosurContainer = UIView()
        addSubview(disclosurContainer)
        disclosurContainer.anchor(
            top: nameLabel.bottomAnchor,
            leading: nil,
            bottom: bottomAnchor,
            trailing: nameLabel.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        disclosurContainer.addSubview(disclosureIndicator)
        disclosureIndicator.anchor(
            top: nil,
            leading: disclosurContainer.leadingAnchor,
            bottom: nil,
            trailing: disclosurContainer.trailingAnchor)
        disclosureIndicator.centerInSuperview(centerType: .centerY)
        
        
        
        
        disclosureIndicator.isHidden = true
        
        stack.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

