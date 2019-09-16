//
//  TextFieldAnimation.swift
//  Movie Groovy
//
//  Created by admin on 12/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

class TextFieldAnimation {
    
    private var constant: CGFloat?
    
    
    
    @objc func keyboardWillShow(notification: Notification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show: Bool, notification: Notification) {
        var  userInfo = notification.userInfo!
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (90.0 as CGFloat) * (show ? 1 : -1)
        var constant = self.getConstraintConstant()
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            constant += changeInHeight
        })
    }
    
    func setConstraintConstant(_ constant: CGFloat) {
        self.constant = constant
    }
    
    func getConstraintConstant() -> CGFloat {
        return self.constant ?? 0
    }
}
