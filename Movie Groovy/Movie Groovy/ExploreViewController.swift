//
//  FirstViewController.swift
//  Movie Groovy
//
//  Created by admin on 08/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    


    var items = ["Apple", "Orange", "Banana", "Rabbit", "Marty", "Bread"]
    var filtered = [String]()
    var selectedItemName = String()
    var searchActive = false
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        collectionView.dataSource = self
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
        
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return number of rows in section
        if searchActive {
            return filtered.count
        } else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! toolCollectionViewCell
        if searchBar.text == "" && !searchActive {
            cell.toolTitle?.text = items[indexPath.row]
        } else {
            cell.toolTitle?.text = filtered[indexPath.row]
        }
        
        return cell
    }
    
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if searchActive && !filtered.isEmpty {
            selectedItemName = filtered[indexPath.row] as String
        } else {
            selectedItemName = items[indexPath.row] as String
        }
        
        self.performSegue(withIdentifier: "collectionCell", sender: self)
    }

    // MARK: Search Bar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        
        if !searchText.isEmpty {
            searchActive = true
            self.filterContentForSearchText()
            self.collectionView.reloadData()
        }
        
        self.collectionView.reloadData()
    }
    
    func filterContentForSearchText() {
        filtered.removeAll(keepingCapacity: false)
        
        for itemName in items {
            let stringToLookFor = itemName as NSString
            let sourceString = searchBar.text! as NSString
            if stringToLookFor.localizedCaseInsensitiveContains(sourceString as String) {
                filtered.append(itemName)
            }
        }
    }
    
    func collectionViewBackgroundTapped() {
        searchBar.resignFirstResponder()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filtered = items.filter({ (item) -> Bool in
            let countryText = item as NSString
            return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        
        self.collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            collectionView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func creatingURL(searchText: String) -> URL {
        let urlString = String(format: "https://api.themoviedb.org/3/search/movie?api_key=072c8bdd40fcf3a56da915ff2677d129&language=en-US&page=1&include_adult=false&query=%@", searchText)
        return URL(string: urlString)!
    }
    
    func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            showNetworkError()
            return nil
        }
    }
    
    func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from:data)
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return [] }
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Whoops...",
                                      message: "There was an error accessing the server." +
            " Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: nil)
        present(alert, animated: true, completion: nil)
        alert.addAction(action)
    }
    
    func createArray()->[String] {
        let url = creatingURL(searchText: "Matrix")
        print("URL: '\(url)'")
        let data = performStoreRequest(with: url)
        let dataArray = (parse(data: data!))
        var stringArray: [String] = []
        for item in dataArray {
            stringArray.append("\(item)")
        }
        
        return stringArray
    }
}
