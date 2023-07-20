//
//  DonationTypeTableViewCell.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 11/07/2023.
//

import UIKit

class DonationTypeTableViewCell: UITableViewCell {
    
    var donationView: DonationTypeView = DonationTypeView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
        //contentView.withHeight(height: 85)
        //contentView.fillSuperview()
        
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
        contentView.addSubview(donationView)
        
        donationView.anchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        donationView.withHeight(height: 65)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        donationView.setHighlighted(highlighted: selected)
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        donationView.setHighlighted(highlighted: highlighted)
    }


}


class DonationTypeView: UIView {

    //MARK: - Attributs
    
    enum State
    {
        case Default
        case Highlight
    }
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-HeavyItalic", size: 20)
        return lbl
    }()
    
    let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext", size: 11)
        return lbl
    }()
    
    lazy var donationImage: DonationIconView = DonationIconView()
    
    private var _state: State = .Default
    
    var viewState: State
    {
        get {
            return _state
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(donationImage)
        
        donationImage.anchor(top: safeAreaLayoutGuide.topAnchor,
                          leading: safeAreaLayoutGuide.leadingAnchor,
                          bottom: safeAreaLayoutGuide.bottomAnchor,
                          trailing: nil,
                          padding: .init(top: 10, left: 15, bottom: 10, right: 0))
        let widthAnchor = donationImage.widthAnchor.constraint(equalTo: donationImage.heightAnchor)
        widthAnchor.isActive = true
        
        let stack = stack(.vertical, views: nameLabel, timeLabel, spacing: 0)

        //dateLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        //nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        stack.anchor(top: safeAreaLayoutGuide.topAnchor,
                     leading: donationImage.trailingAnchor,
                     bottom: safeAreaLayoutGuide.bottomAnchor,
                     trailing: safeAreaLayoutGuide.trailingAnchor,
                     padding: .init(top: 10, left: 15, bottom: 8, right: 5))
        
        
        donationImage.layer.cornerRadius = 45 / 2
        donationImage.layer.masksToBounds = true
        
        backgroundColor = UIColor(named: "PickerButtonBG")
        
        layer.cornerRadius = 20
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHighlighted(highlighted: Bool)
    {
        if highlighted {
            backgroundColor = .lightGray
        }
        else {
            if _state == .Default
            {
                backgroundColor = UIColor(named: "PickerButtonBG")
            }
            else
            {
                backgroundColor = UIColor(named: "AccentColor")
            }
        }
    }
    
    func setState(state: State)
    {
        if _state == state{
            return
        }
        _state = state
        if state == .Default
        {
            backgroundColor = UIColor(named: "PickerButtonBG")
        }
        else
        {
            backgroundColor = UIColor(named: "AccentColor")
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class DonationCellIconView: UIView
{
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(named: "AccentColor")
        return iv
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        backgroundColor = UIColor(named: "AccentBackground")
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




