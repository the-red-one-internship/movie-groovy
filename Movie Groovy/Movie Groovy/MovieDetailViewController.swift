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
    
    //var movieDetails: MovieDetails?
    
    lazy private var viewModel: MovieDetailsVM = MovieDetailsVM(setMovieDetails: { [weak self] details in
            DispatchQueue.main.async {
                self?.movieOverview.text = details.overview
            }
        },
        setPoster: { [weak self] poster in
            DispatchQueue.main.async {
                self?.posterView.image = UIImage(data: poster)
            }
        }
    )
    
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
        self.viewModel.getMovieDetails(for: movieID)
        self.movieLabel.text = movieTitle
    
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if databaseManager.checkTheMovie(movieID: movieID) {
            watchlistBtn.isHidden = true
        } else {
            watchlistBtn.isHidden = false
        }
    }
    
    var movieTitle: String = ""
    var movieID: Int = 0
}
