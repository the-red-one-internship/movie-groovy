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
    var totalPages = 0
    var totalResults = 0
}
class SearchResult:Codable {
    var poster_path: String? = ""
    var adult = false
    var overview: String = ""
    var release_date: String = ""
    var genre_ids: [Int] = []
    var id = 0
    var original_Title: String = ""
    var original_language: String = ""
    var title: String = ""
    var backdrop_path: String? = ""
    var popularity = 0.0
    var vote_count = 0
    var video = false
    var vote_average = 0.0
    
    /* var name:String {
        return trackName ?? ""
    }   */
}
