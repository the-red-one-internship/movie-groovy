//
//  ProfileManager.swift
//  Movie Groovy
//
//  Created by admin on 19/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Firebase

//protocol UserProfileProvider {
//    func userSession() -> Bool
//    func signAsGuest() -> Void
//    func signUp() -> Void
//}

class ProfileManager {
    var isAnonymous: Bool?

    func userSession() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func login(email: String, password: String) {
        let loginViewController = LoginViewController()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
                UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                loginViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func signUp(email: String, password: String, confirmPassword: String) {
        let signUpViewController = SignUpViewController()
        
        if password != confirmPassword {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please, re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            signUpViewController.present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: email, password: password) {(user, error) in
                if error == nil {
                    print("redirect")
                    signUpViewController.performSegue(withIdentifier: "signupToLogin", sender: self)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    signUpViewController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String) {
        let changePasswordVC = ChangePasswordViewController()
        
        let user = Auth.auth().currentUser
        guard let email = user?.email else {return}
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        if newPassword == confirmNewPassword {
            user?.reauthenticate(with: credential) { (_, error) in
                if error != nil {
                    changePasswordVC.displayWarningLabel(withText: "Invalid current password")
                    print("Faild user re-authenticated ", error!)
                } else {
                    print("User re-authenticated")
                    user?.updatePassword(to: newPassword) { error in
                        guard error == nil else {
                            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                switch errorCode {
                                case .weakPassword:
                                    changePasswordVC.displayWarningLabel(withText: "Short password At least 6 characters!")
                                default:
                                    print("There is an error")
                                }
                            }
                            print(error!.localizedDescription)
                            return
                        }
                        changePasswordVC.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            changePasswordVC.displayWarningLabel(withText: "Passwords do not match")
            return
        }
    }
    
    func signAsGuest () {
        Auth.auth().signInAnonymously { (authResult, error) in
            let user = authResult?.user
            let isAnonymous = user?.isAnonymous
            let uid = user?.uid
            
            self.isAnonymous = isAnonymous!
        }
    }
    
    func upgradeAnonymousAccount(email: String, password: String) {
        let viewController = UpgradeAnonymousAccountViewController()
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().currentUser?.link(with: credential) { (user, error) in
            if error == nil {
                print("Anonymous account successfully upgraded")
                let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
                UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
            } else {
                print("Error upgrading anonymous account")
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

extension ProfileManager {
    func getUserID() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    func getUserEmail() -> String {
        return Auth.auth().currentUser?.email ?? "none"
    }
    
}
