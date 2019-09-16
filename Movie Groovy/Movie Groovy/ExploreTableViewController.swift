//
//  ExploreTableViewController.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ExploreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UITableViewDataSourcePrefetching {
    
    @IBOutlet weak var searchBar: UISearchBar!

    private let disposeBag = DisposeBag()
    
    lazy private var viewModel: ExploreVM = ExploreVM( reloading: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
    })
    
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 200
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self

        self.searchBar.rx.text
        .debounce(RxTimeInterval.milliseconds(750), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .subscribe( onNext: { [weak self] searchString in
            if let searchText = searchString {
                print("onNext event \(searchText)")
                self?.viewModel.currentPage = 1
                self?.viewModel.searchText = searchText
            }
        })
        .disposed(by:disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ExploreViewCell
        let movieCell = viewModel.getMovieCell(forCell: indexPath.row)
        cell.filmTitle.text = movieCell.title
        cell.alternativeFilmTitle.text = movieCell.originalTitle
        cell.year.text = movieCell.releaseDate
        cell.ganres.text = movieCell.genres
        cell.movieID = movieCell.movieID!
        cell.raiting.text = movieCell.voteAverage
        if let poster = movieCell.poster{
            cell.filmPoster.image = UIImage(data: poster)
        }else{
            cell.filmPoster.image = nil
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieID = viewModel.getMovieCell(forCell: indexPath.row).movieID!
        vc?.movieTitle = viewModel.getMovieCell(forCell: indexPath.row).title!
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //code
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths{
            if index.row >= (20*viewModel.currentPage)-1 {
               viewModel.currentPage+=1
            }
        }
    }

}
