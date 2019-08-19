//
//  LoginViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import  Firebase

class LoginViewController: UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = email.text, let password = password.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
                UIApplication.shared.delegate?.window??.rootViewController = tabBarVC
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            print("OK")
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
