//
//  TestExploreTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 06/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class TestExploreTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: "ExploreXibCell", bundle: Bundle.main)
        tableView?.register(xib, forCellReuseIdentifier: "ExploreXibCell")
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreXibCell", for: indexPath) as! TestTableViewCell
        let lbl = cell.contentView.viewWithTag(10) as! UILabel
        
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = false
        cell.poster.layer.cornerRadius = 10
        cell.bodyCell.layer.cornerRadius = 10
        cell.bodyCell.layer.shadowRadius = 8
        cell.bodyCell.layer.shadowOpacity = 0.1
        cell.bodyCell.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        let urlString = "https://pp.userapi.com/c851536/v851536244/3948d/3xmzEE0IxM4.jpg"
        let urlImage = URL(string: urlString)
        let imageData = try! Data(contentsOf: urlImage!)
        
        cell.poster.image = UIImage(data: imageData)
        
        lbl.text = "cell # \(indexPath.row)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
