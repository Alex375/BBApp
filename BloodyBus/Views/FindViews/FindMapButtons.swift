//
//  FindMapButtons.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//


import UIKit

class FindMapButtons: UIView {


    var fullScreenButton: UIButton = {
         let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        btn.backgroundColor = .darkGray
        return btn
    }()
    
    var locationButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "location"), for: .normal)
        btn.backgroundColor = .darkGray
        return btn
    }()
    
    var fullScreenCompletion: () -> () = {}
    var locationCompletion: () -> () = {}
    
    init() {
        super.init(frame: .zero)
        
        fullScreenButton.addTarget(self, action: #selector(fullScreen), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(location), for: .touchUpInside)
        
        let stack = stack(.vertical, views: fullScreenButton, locationButton, spacing: 1)
        
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 7
        stack.backgroundColor = .lightGray
        
        stack.fillSuperview()
        
        fullScreenButton.withHeight(height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func fullScreen(sender: Any?)
    {
        fullScreenCompletion()
    }
    
    @objc func location(sender: Any?)
    {
        locationCompletion()
    }
}

