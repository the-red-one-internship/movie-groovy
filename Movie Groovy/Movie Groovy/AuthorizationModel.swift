//
//  AuthorizationModel.swift
//  Movie Groovy
//
//  Created by admin on 19/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Firebase

class AuthorizationModel {
    func checkPassword(view: UIViewController, email: String, password: String, passwordConfirm: String) {
        
        if password != passwordConfirm {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please, re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: email, password: password) {(user, error) in
                if error == nil {
                    print("redirect")
                    view.performSegue(withIdentifier: "signupToLogin", sender: view)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    view.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
