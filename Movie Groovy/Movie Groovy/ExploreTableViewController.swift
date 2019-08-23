//
//  ExploreTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let genreDict = Network.getGenreDict()
    
    let filmDataArray = Network.createFilmDataArray() /*(titles: [String], ids: [Int], posterPaths: [String?], originalTitles: [String?], voteAverage: [String], releaseDate: [String], genres: [[Int]]) = ([], [] ,[], [], [], [], [])*/ //Network.createFilmDataArray()
    lazy var films = filmDataArray.titles
    lazy var originalTitleArr = filmDataArray.originalTitles
    lazy var filmPosterPaths = filmDataArray.posterPaths
    lazy var voteAverageArr = filmDataArray.voteAverage
    lazy var releaseDates = filmDataArray.releaseDate
    lazy var genresArr = filmDataArray.genres
    
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let url = URL(string: Network.URLBase + "movie/\(self.movieID)?api_key=\(Network.APIKey)&language=\(Locale.current.languageCode!)")!
//        let request = URLRequest(url: url)
//        Network.send(request){ response in
//            switch response{
//            case .success( let data):
//                let movieDetails: MovieDetails = Network.parse(data: data)!
//                self.movieOverview.text = movieDetails.overview
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        self.tableView.rowHeight = 200
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ExploreViewCell
        
        cell.filmTitle.text = self.films[indexPath.row]
        cell.raiting.text = self.voteAverageArr[indexPath.row]
        let string = self.releaseDates[indexPath.row]
        let index = string.index(string.startIndex, offsetBy: 4)
        cell.year.text = String(string[..<index])
        cell.alternativeFilmTitle.text = self.originalTitleArr[indexPath.row] ?? nil
        let genreIDs = self.genresArr[indexPath.row]
        var genresString = ""
        for item in genreIDs{
            genresString += genreDict[item]! + " "
        }
        cell.ganres.text = genresString
        if let posterPath = filmPosterPaths[indexPath.row]{
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(posterPath)")
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL!)
                    DispatchQueue.main.async {
                        cell.filmPoster.image = UIImage(data: data!)
                    }
                }
            }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}
