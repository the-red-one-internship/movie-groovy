//
//  RequestHandler.swift
//  Movie Groovy
//
//  Created by admin on 16/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
struct requestHandler {
    static func createFilmDataArray(for film: String = "", page number: Int = 1) -> ([String], [Int]) {
        var urlString = URL(string: "")
        if film == "" {
             urlString = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=072c8bdd40fcf3a56da915ff2677d129&language=\(Locale.current.languageCode!)&page=\(number)")!
        } else {
            let encodedText = film.addingPercentEncoding(
                withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let preUrlString = String(format: "https://api.themoviedb.org/3/search/movie?api_key=072c8bdd40fcf3a56da915ff2677d129&language=\(Locale.current.languageCode!)&page=\(number)&include_adult=false&query=%@", encodedText)
             urlString = URL(string: preUrlString)!
        }
        let data = performStoreRequest(with: urlString!)
        let dataArray = (parse(data: data!))
        var stringArray: [String] = []
        var idArray: [Int] = []
        for item in dataArray {
            idArray.append(item.id)
        }
        for item in dataArray {
            stringArray.append("\(item)")
        }
        
        return (stringArray, idArray)
    }
    
    static func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            //showNetworkError()
            return nil
        }
    }
    
    static func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from:data)
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return [] }
    }
    
//    func showNetworkError() {
//        let alert = UIAlertController(title: "Whoops...",
//                                      message: "There was an error accessing the server." +
//            " Please try again.", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default,
//                                   handler: nil)
//        present(alert, animated: true, completion: nil)
//        alert.addAction(action)
//    }
    
}
