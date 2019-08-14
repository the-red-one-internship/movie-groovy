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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Auth.auth().currentUser != nil {
            //self.performSegue(withIdentifier: "allredyLoggedIn", sender: self)
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
            UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
