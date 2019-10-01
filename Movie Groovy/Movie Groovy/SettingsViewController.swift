//
//  SettingsViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let profileManager = ProfileManager.shared
    private let transition = TransitionAnimator()
    
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var changePasswordBTN: UIButton!
    @IBOutlet weak var exitBTN: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textAlert: UILabel!
    
    
    override func viewDidLoad() {
        
         super.viewDidLoad()
        
        let urlString = "https://pp.userapi.com/c851536/v851536244/3948d/3xmzEE0IxM4.jpg"
        let urlImage = URL(string: urlString)
        let imageData = try! Data(contentsOf: urlImage!)
        
        imageView.image = UIImage(data: imageData)

        if self.profileManager.userSession() {
            switch profileManager.getUserEmail() {
            case "none":
                textAlert.text = "Sign in to not lose data!"
                loginBTN.isEnabled = true
                changePasswordBTN.isEnabled = false
                exitBTN.isEnabled = false
            default:
                textAlert.text = ""
                loginBTN.isEnabled = false
                changePasswordBTN.isEnabled = true
                exitBTN.isEnabled = true
            }
        }
        
        
    }
    
}

// MARK: - Buttons
extension SettingsViewController {
    
    @IBAction func exitButton(_ sender: Any) {
        self.profileManager.signOut()
        
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
