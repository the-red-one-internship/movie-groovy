//
//  MovieDetailViewController.swift
//  
//
//  Created by admin on 16/08/2019.
//

import UIKit
import Firebase

class MovieDetailViewController: UIViewController {
    
    private let profileManager = ProfileManager()

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    @IBAction func addToWatchlist(_ sender: Any) {
        let db = Firestore.firestore()
        let currentUser = profileManager.getUserID()
        let collection = db.collection("\(String(currentUser))")
        
        let alertVC = UIAlertController(title: "\(self.titl)", message: "Фильм добавлен в лист", preferredStyle: .alert)
        
        let addAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            var docRef: DocumentReference? = nil
            docRef = collection.addDocument(data: [
                "title": self.titl,
                "watched": false,
                "film_id": self.movieID
                //"user_id": Auth.auth().currentUser!.uid
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(docRef!.documentID)")
                }
            }
        }
        
        alertVC.addAction(addAction)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //startLoad()
        let url = URL(string: Network.URLBase + "movie/\(self.movieID)?api_key=\(Network.APIKey)&language=\(Locale.current.languageCode!)")!
        let request = URLRequest(url: url)
        Network.send(request){ response in
            switch response{
            case .success( let data):
                let movieDetails: MovieDetails = Network.parse(data: data)!
                self.movieOverview.text = movieDetails.overview
                if let imagePath = movieDetails.poster_path {
                    let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(imagePath)")!
                    let imageRequest = URLRequest(url: imageURL)
                    Network.send(imageRequest){ response in
                        switch response{
                        case .success(let data):
                            self.posterView.image = UIImage(data: data)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        movieLabel.text = titl
    }
    
    var titl: String = ""
    var movieID: Int = 0
//    func startLoad() {
//        let url = URL(string: Network.URLBase + "movie/\(self.movieID)?api_key=\(Network.APIKey)&language=\(Locale.current.languageCode!)")!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                (200...299).contains(httpResponse.statusCode) else {
//                    print(response!)
//                    return
//            }
//            
//            if  let data = data {
//                    let movieDetails = Network.parse(data: data)!
//                    DispatchQueue.main.async {
//                        self.movieOverview.text = movieDetails.overview
//                    }
//                
//                    if let imagePath = movieDetails.poster_path {
//                        let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(imagePath)")!
//                        let subTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
//                            if let error = error {
//                                print(error)
//                                return
//                            }
//                            
//                            guard let httpResponse = response as? HTTPURLResponse,
//                                (200...299).contains(httpResponse.statusCode) else {
//                                    print(response!)
//                                    return
//                            }
//                            
//                            if  let data = data {
//                                DispatchQueue.main.async {
//                                    self.posterView.image = UIImage(data: data)
//                                }
//                            }
//                        }
//                        
//                        subTask.resume()
//                    }
//            }
//        }
//        task.resume()
//    }
}
