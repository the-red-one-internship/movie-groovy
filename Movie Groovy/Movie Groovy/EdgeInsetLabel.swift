//
//  Padding.swift
//  Movie Groovy
//
//  Created by admin on 09/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

@IBDesignable
class EnhancedLabel: UILabel {

    var textInsets = UIEdgeInsets() {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    enum LabelStyle: String {
        case Default = "Default"
        case Genre = "Genre"
        
        var backgroundColor: UIColor {
            switch self {
            case .Genre:
                return #colorLiteral(red: 0, green: 0.3225687146, blue: 1, alpha: 1)
            case .Default:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .Genre:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            default:
                return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        
        var masksToBounds: Bool {
            switch self {
            case .Genre:
                return true
            default:
                return false
            }
        }
    }
    
}

extension EnhancedLabel {
    @IBInspectable var style: String? {
        set { setupWithStyleNamed(newValue)}
        get { return nil }
    }
    
    private func setupWithStyleNamed(_ named: String?) {
        if let styleName = named, let style = LabelStyle(rawValue: styleName) {
            setupWithStyle(style)
        }
    }
    
    func setupWithStyle(_ style: LabelStyle) {
        backgroundColor = style.backgroundColor
        textColor = style.textColor
        layer.masksToBounds = style.masksToBounds
    }
    
    @IBInspectable var paddingLeft: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    @IBInspectable var paddingRight: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    @IBInspectable var paddingTop: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    @IBInspectable var paddingBottom: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom}
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
}
