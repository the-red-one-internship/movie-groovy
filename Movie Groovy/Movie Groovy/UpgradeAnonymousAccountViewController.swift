//
//  UpgradeAccountViewController.swift
//  Movie Groovy
//
//  Created by admin on 26/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class UpgradeAnonymousAccountViewController: UIViewController {

    private let profileManager = ProfileManager.shared
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func upgradeAction(_ sender: Any) {
        guard let email = email.text,
            let password = password.text
            else { return }
        
        profileManager.setViewController(self)
        profileManager.upgradeAnonymousAccount(email: email, password: password)
    }
    
}
