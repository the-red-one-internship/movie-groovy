//
//  SignUpViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let profileManager = ProfileManager()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let email = email.text, let password = password.text, let confirmPassword = confirmPassword.text else {return}
        
        profileManager.signUp(email: email, password: password, confirmPassword: confirmPassword)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
