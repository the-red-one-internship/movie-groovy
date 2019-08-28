//
//  ExploreTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    var movieData: MovieDataProvider = Network()
    
    var genreDict: [Int: String] = [:] {
        willSet{
            movieData.getMovieData(){
                [weak self] results in
                self?.movieDataArr = results
            }
        }
    }
    
    var movieDataArr: [SearchResult] = [] {
        willSet{
            for film in newValue{
                films.append(film.title)
                originalTitleArr.append(film.original_title)
                filmPosterPaths.append(film.poster_path)
                voteAverageArr.append(String(film.vote_average))
                releaseDates.append(film.release_date)
                genresArr.append(film.genre_ids)
            }
            self.tableView.reloadData()
        }
    }

    var films = [String]()
    var originalTitleArr = [String?]()
    var filmPosterPaths = [String?]()
    var voteAverageArr = [String]()
    var releaseDates = [String]()
    var genresArr = [[Int]]()
    
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieData.getGenreDict(){
            [weak self] genreDictionary in
            self?.genreDict = genreDictionary
        }

        self.tableView.rowHeight = 200
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ExploreViewCell
        
        if let url = self.filmPosterPaths[indexPath.row]{
            movieData.getPosterImage(from: url){
                imageData in
                cell.filmPoster.image = UIImage(data: imageData)
            }
        }
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

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //code
    }

}
