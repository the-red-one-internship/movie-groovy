//
//  Film.swift
//  Movie Groovy
//
//  Created by admin on 22/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
//Encodable
struct Film: Codable {
    var id: String
    var title: String
    var watched: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case watched
    }
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "watched": watched
        ]
    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(title, forKey: .title)
//        try container.encode(watched, forKey: .watched)
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        title = try container.decode(String.self, forKey: .title)
//        watched = try container.decode(Bool.self, forKey: .watched)
//    }
}

extension Film {
    init?(dictionary: [String: Any], id: String) {
        guard let title = dictionary["title"] as? String,
            let watched = dictionary["watched"] as? Bool
            else { return nil }

        self.init(id: id, title: title, watched: watched)
    }
    
}
