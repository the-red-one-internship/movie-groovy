//
//  Film.swift
//  Movie Groovy
//
//  Created by admin on 22/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct Films {
    
    var id: String
    var title: String
    var watched: Bool

    var dictionary: [String: Any] {
        return [
            "title": title,
            "watched": watched
        ]
    }
    
}

extension Films {
    init?(dictionary: [String: Any], id: String) {
        guard let title = dictionary["title"] as? String,
            let watched = dictionary["watched"] as? Bool
            else { return nil }

        self.init(id: id, title: title, watched: watched)
    }
    
}
