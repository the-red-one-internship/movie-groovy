//
//  MovieDetailViewController.swift
//  
//
//  Created by admin on 16/08/2019.
//

import UIKit
import Firebase

class MovieDetailViewController: UIViewController {
    
    private let profileManager = ProfileManager()
    private let databaseManager = DatabaseManager()

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movieData: MovieDataProvider = Network()
    
    @IBAction func addToWatchlist(_ sender: Any) {
        let currentUser = profileManager.getUserID()
        let collection = databaseManager.getCollection(currentUser: currentUser)
        
        let alertVC = UIAlertController(title: "\(self.movieTitle)", message: "Фильм добавлен в лист", preferredStyle: .alert)
        
        let addAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            var docRef: DocumentReference? = nil
            docRef = collection.addDocument(data: [
                "title": self.movieTitle,
                "watched": false,
                "film_id": self.movieID
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(docRef!.documentID)")
                }
            }
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
    }
    
    var movieTitle: String = ""
    var movieID: Int = 0
    var movieDetails: MovieDetails? {
        willSet{
            movieOverview.text = newValue?.overview
        }
    }
}
