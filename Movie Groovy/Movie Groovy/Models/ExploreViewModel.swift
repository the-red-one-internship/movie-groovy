//
//  ExploreViewModel.swift
//  Movie Groovy
//
//  Created by admin on 12/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
class ExploreVM{
    struct MovieCellVM {
        let title: String?
        let originalTitle: String?
        let releaseDate: String?
        var poster: Data?
        let movieID: Int?
        let posterPath: String?
        let genres: String?
        let voteAverage: String
        
    }
    private let movieDataProvider: MovieDataProvider
    private var searchResults = [SearchResult]() {
        willSet{
            var temporaryCells = [MovieCellVM]()
            var paths = [String?]()
            for item in newValue{
                var genres = String("")
                for genre in item.genre_ids{
                        genres.append(self.genreDict[genre]! + " ")
                }
                paths.append(item.poster_path)

                temporaryCells.append(MovieCellVM(
                    title: item.title,
                    originalTitle: item.original_title,
                    releaseDate: item.release_date,
                    poster: nil,
                    movieID: item.id,
                    posterPath: item.poster_path,
                    genres: genres,
                    voteAverage: String(item.vote_average)))
    
            }
            self.movieCells = temporaryCells
            var number: Int = 0
            for item in paths{
                guard let str = item else {
                    number += 1
                    continue
                }
                let num = number
                self.movieDataProvider.getPosterImage(from: str){ [weak self] posterData in
                    self?.movieCells[num].poster = posterData
                }
                number += 1
            }
        }
    }
    
    var currentPage: Int {
        didSet{
            guard self.currentPage > 1 else { return }
            self.movieDataProvider.getMovieDataSearch(for: self.searchText, page: self.currentPage) { [weak self ] results in
                self?.searchResults += results
            }
        }
    }
    
    var searchText: String = ""{
        didSet{
            self.movieDataProvider.getMovieDataSearch(for: self.searchText, page: 1) { [ weak self ] results in
                self?.searchResults = results
            }
        }
    }
    
    private var genreDict : [Int: String] = [53: "Thriller", 18: "Drama", 10751: "Family", 27: "Horror", 99: "Documentary", 14: "Fantasy", 80: "Crime", 10749: "Romance", 12: "Adventure", 9648: "Mystery", 16: "Animation", 878: "Science Fiction", 36: "History", 35: "Comedy", 10402: "Music", 10752: "War", 37: "Western", 28: "Action", 10770: "TV Movie"]
    
    private var reloadingTableView: (()->())?

    private var movieCells = [MovieCellVM]() {
        didSet{
            self.reloadingTableView?()
        }
    }
    
    func getMovieCell(forCell number: Int) -> MovieCellVM {
        return movieCells[number]
    }
    
    func getNumberOfCells() -> Int{
        return self.movieCells.count
    }
    
    init(with dataSource: MovieDataProvider = Network(), reloading: @escaping (()->()) ){
        self.reloadingTableView = reloading
        self.currentPage = 1
        self.movieDataProvider = dataSource
    }
}
