//
//  DetailInfoViewButton.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 12/07/2023.
//

import UIKit

class DetailInfoViewButton: UIView {

    lazy var infoView: DetailInfoView = DetailInfoView()
    lazy var button = UIButton()
    
    var isEnabled: Bool {
        get {
            return button.isEnabled
        }
        set {
            button.isEnabled = newValue
            infoView.selectable = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        
        addSubview(infoView)
        infoView.fillSuperview()
        
        addSubview(button)
        button.fillSuperview()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
