//
//  SignUpViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

//import UIKit
import UIKit

class SignUpViewController: UIViewController, UITabBarControllerDelegate, UITextFieldDelegate {
    
    private let profileManager = ProfileManager.shared
    
    private var activeTextField: UITextField!

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let email = email.text, let password = password.text, let confirmPassword = confirmPassword.text else { return }

        profileManager.setViewController(self)
        if password != confirmPassword {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please, re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)

        } else {
            profileManager.signUp(email: email, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.delegate = self
        self.password.delegate = self
        self.confirmPassword.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        
        scrollView.bounces = false
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
        scrollView.bounces = true
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        self.getContentInsets(sender: sender, action: "show")
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        self.getContentInsets(sender: sender, action: "hide")
    }
    
    func getContentInsets(sender: Notification, action: String) {
        let info = sender.userInfo! as NSDictionary
        let value = info.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize = value.cgRectValue.size
        switch action {
        case "show":
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 5, right: 0)
            self.scrollTextToVisible(keyboardSize: keyboardSize)
        case "hide":
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -keyboardSize.height - 5 , right: 0)
        default:
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    func scrollTextToVisible(keyboardSize: CGSize) {
        var aRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        let activeTextFieldRect = activeTextField.frame
        let activeTextFieldOrigin = activeTextFieldRect.origin
        
        if !aRect.contains(activeTextFieldOrigin) {
            scrollView.scrollRectToVisible(activeTextFieldRect, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        } else if textField == password {
            confirmPassword.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        scrollView.isScrollEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
        scrollView.isScrollEnabled = false
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            print("OK")
        }
    }
}
