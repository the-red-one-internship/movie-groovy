//
//  ChangePasswordViewController.swift
//  Movie Groovy
//
//  Created by admin on 14/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    private let profileManager = ProfileManager.shared

    @IBOutlet weak var warrningLabel: UILabel!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let currentPassword = currentPassword.text, let newPassword = newPassword.text, let confirmNewPassword = confirmNewPassword.text else { return }
        
        profileManager.setViewController(self)
        profileManager.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { error in
            self.displayWarningLabel(withText: error)
            
        }
        
    }
    
    func displayWarningLabel (withText text: String) {
        self.warrningLabel.alpha = 0
        self.warrningLabel.text = text
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in self?.warrningLabel.alpha = 1}) { [weak self] complete in
            self?.warrningLabel.alpha = 0
        }
    }
    
}
