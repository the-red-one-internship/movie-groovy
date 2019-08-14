//
//  TabBarViewController.swift
//  Movie Groovy
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // сначала мы при переходе попадаем в наш tabBarController
//        let barViewControllers = segue.destination as! UITabBarController
//        // допустим нам нужно взять у tabBar контроллер по индексу 1
//        // и для примера пускай это будет UINavigationController
//        let navViewControllers = barViewControllers.viewControllers![1] as! UINavigationController
//        // ну и вот мы добрались до нужного контроллера
//        //let destinationViewController = navViewControllers.topviewcontroller as! LoginViewController
//        let destinationViewController = navViewControllers.topViewController as! LoginViewController
//        // дальше все как обычно
//        //destinationViewController.aaa = "мы передали данные чаерез Segue"
//        destinationViewController.loginAction(sender as Any)
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
