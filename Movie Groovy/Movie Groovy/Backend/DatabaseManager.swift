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
    
    private let profileManager = ProfileManager()
    lazy private var user = profileManager.getUserID()
    lazy private var collection = self.getCollection(currentUser: self.user)
    
    let db = Firestore.firestore()
    
    private var isAdded = false
    
    func getCollection(currentUser: String) -> CollectionReference {
        return db.collection("\(currentUser)")
    }
    
    func addToWatchlist(movieTitle: String, movieID: Int) {
        var docRef: DocumentReference? = nil
        docRef = getCollection(currentUser: user).addDocument(data: [
            "title": movieTitle,
            "watched": false,
            "film_id": movieID
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(docRef!.documentID)")
            }
        }
    }
    
    

   // я забыла, что сохраняю фильмы - документы не под id фильма, а под сгенерированным ключом

    func checkTheMovie(movieID: Int) -> Bool {
        let collection = self.collection
        let docRef = collection.document(String(movieID))
        
        docRef.getDocument { (document, error) in
            
            if let document = document,
                document.exists {
                self.isAdded = self.isAddedMovie(word: "added")
            } else {
                print("Document does not exist")
                self.isAdded = self.isAddedMovie(word: "not added")
            }
        }
        
        return self.isAdded
    }
    
    func isAddedMovie(word: String) -> Bool {
        switch word {
        case "added":
            return true
        default:
            return false
        }
    }
    
}
