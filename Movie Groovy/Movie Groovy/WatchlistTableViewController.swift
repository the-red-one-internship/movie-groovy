//
//  WatchlistTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 22/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

class WatchlistTableViewController: UITableViewController {

    private let profileManager = ProfileManager.shared
    lazy private var currentUser = profileManager.getUserID()
    
    private var documents: [DocumentSnapshot] = []
    public var films: [Film] = []
    private var listener : ListenerRegistration!
    
    private var db = DatabaseManager()
    lazy private var collection = db.getCollection(currentUser: currentUser)
    
    fileprivate func baseQuery() -> Query {
        return collection.limit(to: 50)
    }
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.query = baseQuery()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.listener.remove()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listener = query?.addSnapshotListener { (documents, error) in
            guard let snapshot = documents else {
                print("Error fetching documents results: \(error!)")
                return
            }
            
            let results = snapshot.documents.map { (document) -> Film in
                if let film = Film(dictionary: document.data(), id: document.documentID) {
                    return film
                } else {
                    fatalError("Unable to initialize type \(Film.self) with dictionary \(document.data())")
                }
            }
            
            self.films = results
            self.documents = snapshot.documents
            self.tableView.reloadData()
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistCell", for: indexPath)
        let item = self.films[indexPath.row]
        
        cell.textLabel!.text = item.title
        cell.textLabel!.textColor = item.watched == false ? UIColor.black : UIColor.lightGray

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = films[indexPath.row]
        let collection = self.collection
        
        collection.document(item.id).updateData([
            "watched": !item.watched,
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully update")
            }
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = films[indexPath.row]
            _ = collection.document(item.id).delete()
        }

    }

}
