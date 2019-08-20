//
//  StartViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    private let profileManager = ProfileManager()

    @IBAction func loginAsGuest(_ sender: Any) {
        self.showHomePage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.profileManager.userSession() {
            self.showHomePage()
        }
    }
    
    private func showHomePage() {
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
        UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
    }

}
