//
//  ViewController.swift
//  Movie Groovy
//
//  Created by admin on 12/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let collectionView:UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
}
