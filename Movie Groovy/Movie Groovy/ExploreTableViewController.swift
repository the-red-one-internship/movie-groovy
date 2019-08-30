//
//  ExploreTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UITableViewDataSourcePrefetching {
    
    
    private var movieData: MovieDataProvider = Network()
    private var currentPage: Int = 1
    private var searchText: String = ""
    private var genreDict: [Int: String] = [:] {
        willSet{
            movieData.getMovieData(for: currentPage){
                [weak self] results in
                self?.movieDataArr = results
            }
        }
    }
    
    private var movieDataArr: [SearchResult] = [] {
        willSet{
            films = []
            originalTitleArr = []
            filmPosterPaths = []
            voteAverageArr = []
            releaseDates = []
            genresArr = []
            movieIDs = []
            for film in newValue{
                films.append(film.title)
                originalTitleArr.append(film.original_title)
                filmPosterPaths.append(film.poster_path)
                voteAverageArr.append(String(film.vote_average))
                releaseDates.append(film.release_date ?? "-")
                genresArr.append(film.genre_ids)
                movieIDs.append(film.id)
            }
            self.tableView.reloadData()
        }
    }

    private var films = [String]()
    private var originalTitleArr = [String?]()
    private var filmPosterPaths = [String?]()
    private var voteAverageArr = [String]()
    private var releaseDates = [String]()
    private var genresArr = [[Int]]()
    private var movieIDs = [Int]()
    
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
        self.tableView.prefetchDataSource = self
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
        } else{
            cell.filmPoster.image = nil
        }
        cell.filmTitle.text = self.films[indexPath.row]
        cell.raiting.text = self.voteAverageArr[indexPath.row]
        let string = self.releaseDates[indexPath.row]
        if string != "",
            string != "-" {
            let index = string.index(string.startIndex, offsetBy: 4)
            cell.year.text = String(string[..<index])
        }
        else {
            cell.year.text = "-"
        }
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieID = movieIDs[indexPath.row]
        vc?.movieTitle = films[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //code
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieData.getMovieDataSearch(for: searchText, page: 1){
            [unowned self ] results in
            self.movieDataArr = results
        }
        self.searchText = searchText
        self.currentPage = 1
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths{
            if index.row >= (20*currentPage)-1 {
               currentPage+=1
                movieData.getMovieDataSearch(for: searchText, page: currentPage){
                    [weak self] results in
                    self?.movieDataArr += results
                }
            }
        }
        print()
        
    }
}
