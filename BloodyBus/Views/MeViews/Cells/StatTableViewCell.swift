//
//  StatTableViewCell.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 07/07/2023.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    lazy var statView = StatView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(statView)
        statView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        

        // Configure the view for the selected state
    }
}
