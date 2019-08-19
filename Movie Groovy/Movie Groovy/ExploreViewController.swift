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
   
    var filmDataArray = requestHandler.createFilmDataArray()
    lazy var items = filmDataArray.0
    lazy var filmsID = filmDataArray.1
    
    var filtered = [String]()
    var selectedItemName = String()
    var searchActive = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.becomeFirstResponder()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ToolCollectionViewCell
        if searchBar.text == "" && !searchActive {
            cell.filmTitle?.text = items[indexPath.row]
        } else {
            cell.filmTitle?.text = filtered[indexPath.row]
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
    
    // MARK: -
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        vc?.titl = items[indexPath.row]
        vc?.movieID = filmsID[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

