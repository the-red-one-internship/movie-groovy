//
//  SignUpViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITabBarControllerDelegate {
    
    private let profileManager = ProfileManager()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            print("OK")
        }
    }
}
