//
//  ChangePasswordViewController.swift
//  Movie Groovy
//
//  Created by admin on 14/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var warrningLabel: UILabel!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let currentPassword = currentPassword.text, let newPassword = newPassword.text, let confirmNewPassword = confirmNewPassword.text else {
            return
        }
        let user = Auth.auth().currentUser
        guard let email = user?.email else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        if newPassword == confirmNewPassword {
            user?.reauthenticate(with: credential, completion: { (_, error) in
                if error != nil {
                    self.displayWarningLabel(withText: "Неверный текущий пароль")
                    print("Faild user re-authenticated", error!)
                } else {
                    print("User re-authenticated")
                    user?.updatePassword(to: newPassword) { error in
                        guard error == nil else {
                            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                switch errorCode {
                                case .weakPassword:
                                    self.displayWarningLabel(withText: "Короткий пароль. Минимум 6 знаков!")
                                default:
                                    print("There is an error")
                                }
                            }
                            print(error!.localizedDescription)
                            return
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        } else {
            self.displayWarningLabel(withText: "Пароли не совпадают")
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayWarningLabel (withText text: String) {
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
