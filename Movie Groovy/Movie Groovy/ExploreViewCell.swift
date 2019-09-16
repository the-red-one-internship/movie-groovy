//
//  ExploreViewCell.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ExploreViewCell: UITableViewCell {

    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var alternativeFilmTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var ganres: UILabel!
    @IBOutlet weak var raiting: UILabel!
    
    var movieID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
