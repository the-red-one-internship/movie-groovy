//
//  MDViewController.swift
//  Movie Groovy
//
//  Created by admin on 17/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class MDViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var labelRaiting: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var movieOverviewHeight: NSLayoutConstraint!
    @IBOutlet weak var crutch: NSLayoutConstraint!
    
    
    
    private var isMovieOverviewAtMaxHeight = false
    
    @IBAction func readMoreAction(_ sender: Any) {
        
        let arrowDown = UIImage(named: "arrow down")
        let arrowUp = UIImage(named: "arrow up")
        
        if isMovieOverviewAtMaxHeight {
            readMoreButton.setImage(arrowDown, for: .normal)
            readMoreButton.imageView?.contentMode = .scaleAspectFit
            isMovieOverviewAtMaxHeight = false
            movieOverviewHeight.constant = 70
            //crutch.constant -= 5.4
        }
        else {
            readMoreButton.setImage(arrowUp, for: .normal)
            readMoreButton.imageView?.contentMode = .scaleAspectFit
            isMovieOverviewAtMaxHeight = true
            movieOverviewHeight.constant = getMovieOverviewHeight(text: text, width: view.bounds.width, font: .systemFont(ofSize: 17))
            //crutch.constant += 5.4
        }
        
    }
    
    private let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    func getMovieOverviewHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        movieOverview.frame.size.width = width
        movieOverview.font = font
        movieOverview.numberOfLines = 0
        movieOverview.text = text
        movieOverview.sizeToFit()
        
        return movieOverview.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieOverview.text = text
    
        self.addPosterImage()
        self.addNavBarButtons()
    
    }
    
    func addNavBarButtons() {
        let backButtonImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func addPosterImage() {
        let urlString = "https://about.canva.com/wp-content/uploads/sites/3/2015/01/concert_poster.png"
        let urlImage = URL(string: urlString)
        let imageData = try! Data(contentsOf: urlImage!)
        
        self.poster.image = UIImage(data: imageData)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }

}
