//
//  Film.swift
//  Movie Groovy
//
//  Created by admin on 22/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct Film {
    var id: String
    var title: String
    var watched: Bool
    //var id_film: String
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "watched": watched
        ]
    }
}

extension Film {
    init?(dictionary: [String: Any], id: String) {
        guard let title = dictionary["title"] as? String,
            let watched = dictionary["watched"] as? Bool
            else { return nil }
        
        self.init(id: id, title: title, watched: watched)
    }
}
