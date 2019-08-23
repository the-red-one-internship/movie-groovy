////
////  FirestoreProvider.swift
////  Movie Groovy
////
////  Created by admin on 22/08/2019.
////  Copyright © 2019 admin. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class FirestoreProvider {
//    var documents: [DocumentSnapshot] = []
//    var listener: ListenerRegistration!
//    public var films: [Film] = []
//    
//    func baseQuery() -> Query {
//        return Firestore.firestore().collection("films").limit(to: 40)
//    }
//    
//    var query: Query? {
//        didSet {
//            if let listener = listener {
//                listener.remove()
//            }
//        }
//    }
//    
//    func readingData() {
//        self.listener = query?.addSnapshotListener { (documents, error) in
//            guard let snapshot = documents else {
//                print("Error fetching documents results: \(error!)")
//                return
//            }
//            
//            let results = snapshot.documents.map { (document)-> Film in
//                if let film = Film(dictionary: document.data(), id: document.documentID) {
//                    return film
//                } else {
//                    fatalError("Unable to initialize type \(Film.self) with dictionary \(document.data())")
//                }
//            }
//            
//            self.films = results
//            self.documents = snapshot.documents
//        }
//        print(self.films)
//    }
//    
//}
