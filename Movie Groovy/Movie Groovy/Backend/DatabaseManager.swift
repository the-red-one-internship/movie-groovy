//
//  FirestoreProvider.swift
//  Movie Groovy
//
//  Created by admin on 22/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager {
    static let shared  = DatabaseManager()
    
    private init() { }
    
    private let profileManager = ProfileManager.shared
    lazy private var user = profileManager.getUserID()
    lazy private var collection = self.getCollection(currentUser: self.user)
    
    let db = Firestore.firestore()

    
    func getCollection(currentUser: String) -> CollectionReference {
        return db.collection("\(currentUser)")
    }
    
    func addToWatchlist(movieTitle: String, movieID: Int) {
        collection.document("\(movieID)").setData([
            "title": movieTitle,
            "watched": false
        ]) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(movieID)")
            }
        }
        
    }

    func checkTheMovie(movieID: Int) -> Bool {
        let collection = self.collection
        
        collection.document("\(movieID)").getDocument { (document, error) in
            if let document = document, document.exists {
                print("документ существует")
            } else {
                print("документ не существует")
            }
        }
        
       return false
    }
    
}
