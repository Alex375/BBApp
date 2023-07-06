//
//  UIView+StackView.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 06/07/2023.
//

import Foundation
import UIKit


extension UIColor {
    static func rgb(red: Int = 0, green: Int = 0, blue:Int = 0, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: alpha)
    }
    
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}


extension UIView {
    
    /**
     Function to apply anchored constraints
     
     - Parameters:
        - top: Top reference constraint
        - leading: Leading reference constraint
        - bottom: Bottom reference constraint
        - trailing: Trailling reference constraint
        - padding: Contant for each anchored constraint
        - size: Contants for size constraints
     
     - Returns:
        AnchoredContraint with all non-nill contraints (discardable).
     - Warning: Make sure to add the view to the superView as a subbView before calling the function otherwise an error will occure.
    */
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    enum CenterType {
        case centerX
        case centerY
        case centerXandY
    }
    
    func centerInSuperview(centerType: CenterType) {
        translatesAutoresizingMaskIntoConstraints = false
        switch centerType {
        case .centerX:
            if let superViewCenterXAnchor = superview?.centerXAnchor {
                centerXAnchor.constraint(equalToSystemSpacingAfter: superViewCenterXAnchor, multiplier: 1).isActive = true
            }
        case .centerY:
            if let superViewCenterYAnchor = superview?.centerYAnchor {
                centerYAnchor.constraint(equalToSystemSpacingBelow: superViewCenterYAnchor, multiplier: 1).isActive = true
            }
        case .centerXandY:
            if let superViewCenterXAnchor = superview?.centerXAnchor {
                centerXAnchor.constraint(equalToSystemSpacingAfter: superViewCenterXAnchor, multiplier: 1).isActive = true
            }
            if let superViewCenterYAnchor = superview?.centerYAnchor {
                centerYAnchor.constraint(equalToSystemSpacingBelow: superViewCenterYAnchor, multiplier: 1).isActive = true
            }
        }
    }
    
    func constrainHeight(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainWidth(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    @discardableResult
    func stack(_ axis: NSLayoutConstraint.Axis, views: UIView..., spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        addSubview(stackView)
        return stackView
    }
    
    func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    @available(iOS , introduced: 12.4)
    convenience init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    @discardableResult
    func withSize(size: CGSize) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func withHeight(height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func withBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
    
}

extension UIStackView {
    
    @discardableResult
    func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
}

extension UIEdgeInsets {
    static func allSides(side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }
}

extension UITextField {
    func escape(incompletMessage: String) {
        layer.borderColor = UIColor.red.cgColor
        text = ""
        placeholder = incompletMessage
    }
}


/**
 Abstract base class for UIColectionViewCell
 
 */
class UICollectionViewBaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     Set up your subviews in the cell.
     
     */
    func setUpViews() {
        
    }
}
