//
//  SignUpViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    private let model = AuthorizationModel()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let email = email.text, let password = password.text, let passwordConfirm = passwordConfirm.text else {return}
        
        model.checkPassword(view: self, email: email, password: password, passwordConfirm: passwordConfirm)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
