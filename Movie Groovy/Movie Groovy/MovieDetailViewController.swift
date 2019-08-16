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
    override func viewDidLoad() {
        super.viewDidLoad()
        movieLabel.text = titl
        let urlString = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=072c8bdd40fcf3a56da915ff2677d129&language=\(Locale.current.languageCode!)")!
        let data = requestHandler.performStoreRequest(with: urlString)
        let movieDetails: MovieDetails? = requestHandler.parse(data: data!)
        movieOverview.text = movieDetails!.overview
        
        
        // Do any additional setup after loading the view.
    }
    
    var titl: String = ""
    var movieId: Int = 0
    //var movie: SearchResult = SearchResult()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
