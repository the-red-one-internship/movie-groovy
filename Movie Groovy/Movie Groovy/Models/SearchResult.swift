//
//  SearchResult.swift
//  Movie Groovy
//
//  Created by admin on 12/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct ResultArray:Codable {
    let page: Int?
    let results: [SearchResult]
    let totalPages: Int?
    let totalResults: Int?
}

struct SearchResult:Codable {
    let poster_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let genre_ids:[Int]
    let id: Int?
    let original_title: String?
    let original_language: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_count: Int?
    let video: Bool?
    let vote_average: Double
}

struct MovieDetails: Codable {
    let overview: String?
    let original_title: String?
    let tagline: String?
    let revenue: Int?
    let release_date: String?
    let poster_path: String?
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Genres: Codable{
    let genres: [Genre]
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
