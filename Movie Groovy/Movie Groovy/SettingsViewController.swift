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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

// MARK: - Buttons
extension SettingsViewController {
    
    @IBAction func languageButton(_ sender: Any) {
        let languageViewController = storyboard!.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        languageViewController.transitioningDelegate = self as! UIViewControllerTransitioningDelegate
        languageViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(languageViewController, animated: true, completion: nil)
        }
    
    @IBAction func changePasswordButton(_ sender: Any) {
        let changePasswordViewController = storyboard!.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        changePasswordViewController.transitioningDelegate = self as! UIViewControllerTransitioningDelegate
        changePasswordViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(changePasswordViewController, animated: true, completion: nil)
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
