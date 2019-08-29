//
//  MovieDetailViewController.swift
//  
//
//  Created by admin on 16/08/2019.
//

import UIKit
import Firebase

class MovieDetailViewController: UIViewController {
    
    private let databaseManager = DatabaseManager()

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var watchlistBtn: UIButton!
    
    var movieData: MovieDataProvider = Network()
    
    @IBAction func addToWatchlist(_ sender: Any) {
        
        let alertVC = UIAlertController(title: "\(self.movieTitle)", message: "Add  to list", preferredStyle: .alert)
        
        let addAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            self.databaseManager.addToWatchlist(movieTitle: self.movieTitle, movieID: self.movieID)
        }
        
        alertVC.addAction(addAction)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieData.getMovieDetails(for: movieID){
            [weak self] movieDT in
            self?.movieDetails = movieDT
            if let posterPath = movieDT.poster_path {
                self?.movieData.getPosterImage(from: posterPath) {
                    [weak self] data in
                    self?.posterView.image = UIImage(data: data)
                }
            }
        }
        movieLabel.text = movieTitle
        
        if databaseManager.checkTheMovie(movieID: movieID) {
            watchlistBtn.isEnabled = false
        } else {
            watchlistBtn.isEnabled = true
        }
    }
    
    var movieTitle: String = ""
    var movieID: Int = 0
    var movieDetails: MovieDetails? {
        willSet{
            movieOverview.text = newValue?.overview
        }
    }
    
    func checkList() {
        
    }
}
