//
//  SettingsViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    let transition = TransitionAnimator()
    
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var changePasswordBTN: UIButton!
    @IBOutlet weak var exitBTN: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        let urlString = "https://pp.userapi.com/c851536/v851536244/3948d/3xmzEE0IxM4.jpg"
        let urlImage = URL(string: urlString)
        let imageData = try! Data(contentsOf: urlImage!)
        
        super.viewDidLoad()

        if Auth.auth().currentUser != nil {
            loginBTN.isEnabled = false
            changePasswordBTN.isEnabled = true
            exitBTN.isEnabled = true
        } else {
            loginBTN.isEnabled = true
            changePasswordBTN.isEnabled = false
            exitBTN.isEnabled = false
        }
        
        imageView.image = UIImage(data: imageData)
        
    }
    
}

// MARK: - Buttons
extension SettingsViewController {
    
    @IBAction func loginButton(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "Auth") as! StartViewController
        self.present(loginVC, animated: false, completion: nil)
    }
    
    @IBAction func changePasswordButton(_ sender: Any) {
        let changePasswordViewController = storyboard!.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        changePasswordViewController.transitioningDelegate = self as! UIViewControllerTransitioningDelegate
        changePasswordViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(changePasswordViewController, animated: true, completion: nil)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let inital = storyBoard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = inital
        
    }
}

// MARK: - Transition
extension SettingsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        transition.duration = 0.5
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
