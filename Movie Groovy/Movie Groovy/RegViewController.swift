//
//  RegViewController.swift
//  Movie Groovy
//
//  Created by admin on 12/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import LBTATools

class RegViewController: LBTAFormController {

    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0, green: 0.3225687146, blue: 1, alpha: 1), target: self, action: #selector(handleCancel))
    
    @objc fileprivate func  handleCancel() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 0, left: 24, bottom: 0, right: 24)
        
        (0...5).forEach { (_) in
            let email = IndentedTextField(placeholder: "Email", padding: 12, cornerRadius: 5, backgroundColor: .white)
            email.constrainHeight(50)
            formContainerStackView.addArrangedSubview(email)
        }
        
        
        formContainerStackView.addArrangedSubview(signUpButton)
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
