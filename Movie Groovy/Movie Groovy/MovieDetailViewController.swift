//
//  MovieDetailViewController.swift
//  
//
//  Created by admin on 16/08/2019.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieLabel.text = titl
        let movieDetails: MovieDetails = requestHandler.getDetails(for: movieID)
        movieOverview.text = movieDetails.overview
        if let imagePath = movieDetails.poster_path {
           let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(imagePath)")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL!)
                DispatchQueue.main.async {
                    self.posterView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    var titl: String = ""
    var movieID: Int = 0
}
