//
//  WatchlistTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 22/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import  Firebase

class WatchlistTableViewController: UITableViewController {

    private var documents: [DocumentSnapshot] = []
    public var films: [Film] = []
    private var listener : ListenerRegistration!
    
    fileprivate func baseQuery() -> Query {
        return Firestore.firestore().collection("films").limit(to: 40)
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        let collection = Firestore.firestore().collection("films")
        
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
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = films[indexPath.row]
            _ = Firestore.firestore().collection("films").document(item.id).delete()
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
   

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
