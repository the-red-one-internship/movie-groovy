//
//  StartViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {

    @IBAction func loginAsGuest(_ sender: Any) {
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
        UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            //self.performSegue(withIdentifier: "allredyLoggedIn", sender: self)
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
            UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
        }
    }

}
