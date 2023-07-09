//
//  StatView.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 07/07/2023.
//


import UIKit

class StatView: UIView {

    lazy var brithLabel = StatLabel()
    lazy var sessionCount = StatLabel()
    
    var birth: String? {
        get {
            return brithLabel.statLabel.text
        }
        set {
            brithLabel.statLabel.text = newValue
        }
    }
    
    var sessions: String? {
        get {
            return sessionCount.statLabel.text
        }
        set {
            sessionCount.statLabel.text = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        brithLabel.titleLabel.text = "me.stat.birth".localized
        sessionCount.titleLabel.text = "me.stat.sessioncount".localized
        
        
        addSubview(brithLabel)
        addSubview(sessionCount)
        sessionCount.statLabel.font = UIFont(name: "AvenirNext-HeavyItalic", size: 17)
        
        let stack = stack(.vertical, views: brithLabel, sessionCount, spacing: 10)
        stack.anchor(
            top: nil,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        stack.centerInSuperview(centerType: .centerY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StatLabel: UIView
{
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .light)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var statLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "AccentColor")
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
        
    init() {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        addSubview(statLabel)
        
        titleLabel.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            trailing: nil)
        
        statLabel.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: titleLabel.trailingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            trailing: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

