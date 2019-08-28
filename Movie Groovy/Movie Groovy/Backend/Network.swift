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

protocol MovieDataProvider {
    func getMovieDetails(for movieID: Int, success: @escaping (MovieDetails)->Void)
    func getPosterImage(from path: String, success: @escaping (Data)->Void)
    func getGenreDict(success: @escaping ([Int: String])->Void)
    func getMovieData(success: @escaping ([SearchResult])->Void)
    func getMovieDataSearch(for searchString: String, page: Int, success: @escaping ([SearchResult])->Void)
}

struct Network {
 
    private let APIKey: String = "072c8bdd40fcf3a56da915ff2677d129"
    private let URLBase = "https://api.themoviedb.org/3/"
    
    private var authStatus: String?
    
    static func createFilmDataArray(for film: String = "", page number: Int = 1) -> (titles: [String], ids: [Int], posterPaths: [String?], originalTitles: [String?], voteAverage: [String], releaseDate: [String], genres: [[Int]]) {
        var urlString = URL(string: "")
        //authStatus = ""
        if film == "" {
             urlString = URL(string: "https://api.themoviedb.org/3/" + "movie/popular?api_key=072c8bdd40fcf3a56da915ff2677d129&language=\(Locale.current.languageCode!)&page=\(number)")!
        } else {
            let encodedText = film.addingPercentEncoding(
                withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let preUrlString = String(format: "https://api.themoviedb.org/3/" + "search/movie?api_key=072c8bdd40fcf3a56da915ff2677d129&language=\(Locale.current.languageCode!)&page=\(number)&include_adult=false&query=%@", encodedText)
             urlString = URL(string: preUrlString)!
        }

        let data = self.performStoreRequest(with: urlString!)
        let dataArray: [SearchResult] = self.parse(data: data!)
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
    
// via Generics
    static func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from:data)
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return [] }
    }
    
    private func parse(data: Data) -> MovieDetails? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(MovieDetails.self, from:data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil

        }
    }
    
    private func parse(data: Data) -> [Genre] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Genres.self, from: data)
            return result.genres
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }

}

extension Network: MovieDataProvider{
    func getGenreDict(success: @escaping ([Int: String])->Void){
        let url = URL(string: self.URLBase + "genre/movie/list?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)")!
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(response!)
                    return
            }
            
            if  let data = data {
                let genreArr: [Genre] = self.parse(data: data)
                let myDictionary = genreArr.reduce([Int: String]()) { (dict, array) -> [Int: String] in
                    var dict = dict
                    dict[array.id] = array.name
                    return dict
                }
                DispatchQueue.main.async {
                    success(myDictionary)
                }
            }
        }
        task.resume()
    }
    
    func getMovieDetails(for movieID: Int, success: @escaping (MovieDetails) -> Void) {
        let url = URL(string: self.URLBase + "movie/\(movieID)?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)")!
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
                        if let error = error {
                            print(error)
                            return
                        }
            
                        guard let httpResponse = response as? HTTPURLResponse,
                            (200...299).contains(httpResponse.statusCode) else {
                                print(response!)
                                return
                        }
            
                        if  let data = data {
                                let movieDetails = self.parse(data: data)!
                                DispatchQueue.main.async {
                                    success(movieDetails)
                                }
                        }
        }
        task.resume()
    }
    
    func getPosterImage(from path: String, success: @escaping (Data)->Void){
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(path)")!
        let task = URLSession.shared.dataTask(with: imageURL){ data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(response!)
                    return
            }
            
            if  let data = data {
                DispatchQueue.main.async {
                    success(data)
                }
            }
        }
        task.resume()
    }
    
    func getMovieData(success: @escaping ([SearchResult])->Void){
        let url = URL(string: self.URLBase + "movie/popular?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)")!
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(response!)
                    return
            }
            
            if  let data = data {
                let results: [SearchResult] = Network.parse(data: data)
                DispatchQueue.main.async {
                    success(results)
                }
            }
        }
        task.resume()
    }
    
    func getMovieDataSearch(for searchString: String, page: Int, success: @escaping ([SearchResult])->Void){
        let encodedText = searchString.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let preUrlString = String(format: self.URLBase + "search/movie?api_key=\(self.APIKey)&language=\(Locale.current.languageCode!)&page=\(page)&include_adult=false&query=%@", encodedText)
        let urlString = URL(string: preUrlString)!
        let task = URLSession.shared.dataTask(with: urlString){ data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(response!)
                    return
            }
            
            if  let data = data {
                let results: [SearchResult] = Network.parse(data: data)
                DispatchQueue.main.async {
                    success(results)
                }
            }
        }
        task.resume()
        
    }
}
