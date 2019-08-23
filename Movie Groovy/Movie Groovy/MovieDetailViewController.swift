//
//  MovieDetailViewController.swift
//  
//
//  Created by admin on 16/08/2019.
//

import UIKit
import Firebase

class MovieDetailViewController: UIViewController {
    
    //private let firestoreProvider = FirestoreProvider()

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    @IBAction func addToWatchlist(_ sender: Any) {
        let collection = Firestore.firestore().collection("films")
        
        let alertVC = UIAlertController(title: "New film", message: "Фильм добавлен в лист", preferredStyle: .alert)
//        alertVC.addTextField { (UITextField) in
//
//        }
        
        let addAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            
            var docRef: DocumentReference? = nil
            docRef = collection.addDocument(data: [
                "title": self.title ?? "None",
                "watched": false
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
        startLoad()
        movieLabel.text = title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    var titl: String = ""
    var movieID: Int = 0
    func startLoad() {
        let url = URL(string: requestHandler.URLBase + "movie/\(self.movieID)?api_key=\(requestHandler.APIKey)&language=\(Locale.current.languageCode!)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
                    let movieDetails = requestHandler.parse(data: data)!
                    DispatchQueue.main.async {
                        self.movieOverview.text = movieDetails.overview
                    }
                
                    if let imagePath = movieDetails.poster_path {
                        let imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(imagePath)")!
                        let subTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
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
                                    self.posterView.image = UIImage(data: data)
                                }
                            }
                        }
                        
                        subTask.resume()
                    }
            }
        }
        task.resume()
    }
}
