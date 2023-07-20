//
//  DetailHeaderView.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 12/07/2023.
//


import UIKit

class DetailHeaderView: UIView {

    lazy var iconView: DonationIconView = DonationIconView()

    lazy var donationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-HeavyItalic", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "AccentColor")
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    
    private var _date: Date?
    
    var date: Date? {
        get {
            return _date
        }
        set {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "EEEE, dd MMM HH:mm"
            if let newValue = newValue {
                dateLabel.text = dateFormatter.string(from: newValue)
            }
            _date = newValue
        }
    }
    
    private var _donation: Int?
    
    var donation: Int? {
        get {
            return _donation
        }
        set {
            iconView.imageView.image = Donation.icon(forDonation: newValue)
            donationLabel.text = Donation.getDonation(with: newValue)
            _donation = newValue
        }
    }
    
    init()
    {
        super.init(frame: .zero)
        
        let labelStack = stack(.vertical, views: donationLabel, dateLabel, spacing: 10)
        
        addSubview(iconView)
        iconView.anchor(top: topAnchor,
                        leading: leadingAnchor,
                        bottom: bottomAnchor,
                        trailing: nil)
        
        iconView.withSize(size: .init(width: 100, height: 100))
        iconView.layer.cornerRadius = 50
        
        labelStack.anchor(top: nil,
                          leading: iconView.trailingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 50, bottom: 0, right: 0))
        labelStack.centerInSuperview(centerType: .centerY)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

