//
//  SearchResult.swift
//  Movie Groovy
//
//  Created by admin on 12/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class ResultArray:Codable {
    var page = 0
    var results = [SearchResult]()
    var totalPages: Int? = 0
    var totalResults: Int? = 0
}

class SearchResult:Codable, CustomStringConvertible {
    var poster_path: String? = ""
    var adult = false
    var overview: String = ""
    var release_date: String = ""
    var genre_ids: [Int] = []
    var id = 0
    var original_title: String? = ""
    var original_language: String = ""
    var title: String = ""
    var backdrop_path: String? = ""
    var popularity = 0.0
    var vote_count = 0
    var video = false
    var vote_average = 0.0
    var description: String {
        return "\(title)"
    }
}

struct MovieDetails: Codable{
    var overview: String? = nil
    var original_title: String = ""
    var tagline: String = ""
    var revenue: Int = 0
    var release_date: String = ""
    var poster_path: String? = nil
}

class Genre: Codable {
    var id: Int
    var name: String
}

class Genres: Codable{
    var genres: [Genre]
}

struct MovieData {
    var titles: [String]
    var ids: [Int]
    var posterPaths: [String?]
    var originalTitles: [String?]
    var voteAverage: [String]
    var releaseDate: [String]
    var genres: [[Int]]
}
