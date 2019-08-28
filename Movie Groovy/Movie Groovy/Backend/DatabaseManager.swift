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
    let db = Firestore.firestore()
    
    func getCollection(currentUser: String) -> CollectionReference {
        return db.collection("\(currentUser)")
    }
    
    func addToWatchlist() {
        
    }
    
}
