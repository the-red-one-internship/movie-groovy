//
//  LanguageViewController.swift
//  Movie Groovy
//
//  Created by admin on 14/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
    }
    
}

// MARK: - Buttons
extension LanguageViewController {
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
