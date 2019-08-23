//
//  RequestHandler.swift
//  Movie Groovy
//
//  Created by admin on 16/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//


// SOLID
// S - single class - single responsibilty
// синхронные вызовы блочат UI
// Изучить как работает URL Loading system
// Именования классов и структур, файлов. Расположение файлов в дереве проекта
// Контроллеры знают про фаербейз - косяк
// Много логики в контроллерах - косяк

// Прочитать o TableView и dequeueReusableCell

import Foundation

struct Network {
   // private(set) var shared: requestHandler
    
    static  let APIKey: String = "072c8bdd40fcf3a56da915ff2677d129"
    static  let URLBase = "https://api.themoviedb.org/3/"
    
    static var authStatus: String?
    
    static func createFilmDataArray(for film: String = "", page number: Int = 1) -> (titles: [String], ids: [Int], posterPaths: [String?], originalTitles: [String?], voteAverage: [String], releaseDate: [String], genres: [[Int]]) {
        var urlString = URL(string: "")
        authStatus = ""
        if film == "" {
             urlString = URL(string: self.URLBase + "movie/popular?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)&page=\(number)")!
        } else {
            let encodedText = film.addingPercentEncoding(
                withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let preUrlString = String(format: URLBase + "search/movie?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)&page=\(number)&include_adult=false&query=%@", encodedText)
             urlString = URL(string: preUrlString)!
        }
        
        let data = self.performStoreRequest(with: urlString!)
        let dataArray: [SearchResult] = parse(data: data!)
        var titleArray: [String] = []
        var idArray: [Int] = []
        var posterPathArray: [String?] = []
        var originalTitleArray:[String?] = []
        var voteAverageArr: [String] = []
        var dateArr: [String] = []
        var genreArr: [[Int]] = []
        for item in dataArray {
            idArray.append(item.id)
            originalTitleArray.append(item.original_title)
            titleArray.append("\(item)")
            posterPathArray.append(item.poster_path)
            voteAverageArr.append(String(item.vote_average))
            dateArr.append(item.release_date)
            genreArr.append(item.genre_ids)
        }
        
        return (titleArray, idArray, posterPathArray, originalTitleArray, voteAverageArr, dateArr, genreArr)
    }
    
    static func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
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
    
    static func parse(data: Data) -> MovieDetails? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(MovieDetails.self, from:data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil

        }
    }
    
    static func parse(data: Data) -> [Genre] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Genres.self, from: data)
            return result.genres
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
    static func getDetails(for movieID: Int) -> MovieDetails {
        let urlString = URL(string: URLBase + "movie/\(movieID)?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)")!
        let data = Network.performStoreRequest(with: urlString)
        return Network.parse(data: data!)!
    }
    
    static func getGenreDict() -> [Int: String] {
        let url = URL(string: self.URLBase + "genre/movie/list?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)")!
        let data = Network.performStoreRequest(with: url)
        let genreArr: [Genre] = parse(data: data!)
        let myDictionary = genreArr.reduce([Int: String]()) { (dict, array) -> [Int: String] in
            var dict = dict
            dict[array.id] = array.name
            return dict
        }
        return myDictionary
    }
    static func send(_ request: URLRequest,
              completion: @escaping (Result<Data, Error>)->Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let result: Result<Data, Error>
            if let error = error {
                // First, check if the network just returned an error
                result = .failure(error)
            } else { let data = data
                result = .success(data!)
            }
            DispatchQueue.main.async {
                completion (result)
            }
        }
        task.resume()
    }

//    static func updateFilmData(ref: MovieData ){
//        let url = URL(string: self.URLBase + "movie/popular?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)")!
//        let request = URLRequest(url: url)
//            self.send(request){ response in
//                switch response{
//                case .success( let data):
//                    let dataArray: [SearchResult] = parse(data: data)
//                    var titleArray: [String] = []
//                    var idArray: [Int] = []
//                    var posterPathArray: [String?] = []
//                    var originalTitleArray:[String?] = []
//                    var voteAverageArr: [String] = []
//                    var dateArr: [String] = []
//                    var genreArr: [[Int]] = []
//                    for item in dataArray {
//                        idArray.append(item.id)
//                        originalTitleArray.append(item.original_title)
//                        titleArray.append("\(item)")
//                        posterPathArray.append(item.poster_path)
//                        voteAverageArr.append(String(item.vote_average))
//                        dateArr.append(item.release_date)
//                        genreArr.append(item.genre_ids)
//                    }
//                    ref = MovieData(titles: <#T##[String]#>, ids: <#T##[Int]#>, posterPaths: <#T##[String?]#>, originalTitles: <#T##[String?]#>, voteAverage: <#T##[String]#>, releaseDate: <#T##[String]#>, genres: <#T##[[Int]]#>)
//                    //self.movieOverview.text = movieDetails.overview
//                case .failure(let error):
//                    print(error)
//                }
//        }
//
//    }
}
