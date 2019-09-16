//
//  MovieDetailsVM.swift
//  Movie Groovy
//
//  Created by admin on 16/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class MovieDetailsVM {
    private var movieDetails: MovieDetails? {
        didSet{
            self.setMovieDetails(self.movieDetails!)
            if let path = movieDetails?.poster_path {
                movieDataProvider.getPosterImage(from: path, success: { [weak self] poster in
                    self?.poster = poster
                })
            }
        }
    }
    private var poster: Data? {
        didSet{
            self.setPoster(self.poster!)
        }
    }
    private let movieDataProvider: MovieDataProvider
    
    func getMovieDetails(for movieID: Int)->Void{
        self.movieDataProvider.getMovieDetails(for: movieID){ [weak self] details in
            self?.movieDetails = details
        }
    }
    private var setMovieDetails: ((MovieDetails)->Void)
    private var setPoster: (Data)->Void
    
    
    init(with dataSource: MovieDataProvider = Network(), setMovieDetails: @escaping (MovieDetails)->Void, setPoster: @escaping (Data)->Void){
        self.movieDataProvider = dataSource
        self.setMovieDetails = setMovieDetails
        self.setPoster = setPoster
    }
}
