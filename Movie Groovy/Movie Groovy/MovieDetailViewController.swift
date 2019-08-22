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
        startLoad()
        movieLabel.text = titl
    }
    
    var titl: String = ""
    var movieID: Int = 0
    func startLoad() {
        let url = URL(string: Network.URLBase + "movie/\(self.movieID)?api_key=\(Network.APIKey)&language=\(Locale.current.languageCode!)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(response!)
                    return
            }
            
            if  let data = data {
                    let movieDetails = Network.parse(data: data)!
                    DispatchQueue.main.async {
                        self.movieOverview.text = movieDetails.overview
                    }
                
                    if let imagePath = movieDetails.poster_path {
                        let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(imagePath)")!
                        let subTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                            if let error = error {
                                print(error)
                                return
                            }
                            
                            guard let httpResponse = response as? HTTPURLResponse,
                                (200...299).contains(httpResponse.statusCode) else {
                                    print(response!)
                                    return
                            }
                            
                            if  let data = data {
                                DispatchQueue.main.async {
                                    self.posterView.image = UIImage(data: data)
                                }
                            }
                        }
                        
                        subTask.resume()
                    }
            }
        }
        task.resume()
    }
}
