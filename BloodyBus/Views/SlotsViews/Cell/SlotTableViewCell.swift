//
//  SlotTableViewCell.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import UIKit

class SlotTableViewCell: UITableViewCell {

    var slotView: SlotView = SlotView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
        //contentView.withHeight(height: 85)
        //contentView.fillSuperview()
        
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
        contentView.addSubview(slotView)
        
        slotView.anchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        slotView.withHeight(height: 65)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        slotView.setHighlighted(highlighted: selected)
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        slotView.setHighlighted(highlighted: highlighted)
    }

    

}
