//
//  ExploreTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let films = ["spider man 1", "spider man 2", "spider man 3", "not spider man"]
    let filmPoster = try! Data(contentsOf: URL(string: "https://upload.wikimedia.org/wikipedia/ru/thumb/1/1f/Spiderman2.jpg/267px-Spiderman2.jpg")!)
    
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 200
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ExploreViewCell
        
        cell.filmTitle.text = self.films[indexPath.row]
        cell.filmPoster.image = UIImage(data: filmPoster)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}
