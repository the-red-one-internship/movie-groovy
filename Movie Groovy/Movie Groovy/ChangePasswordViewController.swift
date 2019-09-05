//
//  ChangePasswordViewController.swift
//  Movie Groovy
//
//  Created by admin on 14/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private let profileManager = ProfileManager.shared

    @IBOutlet weak var warrningLabel: UILabel!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    @IBOutlet weak var currentPasswordBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var newPasswordBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmNewPasswordBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show: Bool, notification: Notification) {
        var  userInfo = notification.userInfo!
        let keyboardframe: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (keyboardframe.height + 1) * (show ? 1 : -1)
        print(changeInHeight)
        print(self.confirmNewPasswordBottomConstraint.constant)
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.confirmNewPasswordBottomConstraint.constant += changeInHeight
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let currentPassword = currentPassword.text, let newPassword = newPassword.text, let confirmNewPassword = confirmNewPassword.text else { return }
        
        profileManager.setViewController(self)
        profileManager.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { error in
            self.displayWarningLabel(withText: error)
            
        }
        
    }
    
    func displayWarningLabel (withText text: String) {
        self.warrningLabel.alpha = 0
        self.warrningLabel.text = text
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in self?.warrningLabel.alpha = 1}) { [weak self] complete in
            self?.warrningLabel.alpha = 0
        }
    }
    
}

extension ChangePasswordViewController {
   
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
