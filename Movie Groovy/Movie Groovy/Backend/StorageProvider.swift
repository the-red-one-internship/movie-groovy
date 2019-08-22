//
//  StorageProvider.swift
//  
//
//  Created by admin on 20/08/2019.
//

import Foundation
import Firebase

private let storage = Storage.storage(url: "gs://movie-groovy-420.appspot.com/")

class StorageProvider {
    let storageRef = storage.reference()
}

//SnapshotListener
//Access data offline
