//
//  UpgradeAccountViewController.swift
//  Movie Groovy
//
//  Created by admin on 26/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class UpgradeAnonymousAccountViewController: UIViewController, UITextFieldDelegate {

    private let profileManager = ProfileManager.shared
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.delegate = self
        self.password.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)

    }
    
    @IBAction func upgradeAction(_ sender: Any) {
        guard let email = email.text,
            let password = password.text
            else { return }
        
        profileManager.setViewController(self)
        profileManager.upgradeAnonymousAccount(email: email, password: password)
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.removeForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if activeTextField.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        scrollView.isScrollEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
        scrollView.isScrollEnabled = false
    }
    
    
}
