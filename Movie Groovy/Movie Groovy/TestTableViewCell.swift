//
//  TestTableViewCell.swift
//  Movie Groovy
//
//  Created by admin on 06/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var bodyCell: UIView!
    @IBOutlet var ganres: [UILabel]!
    
    @IBOutlet weak var ganre_1: UILabel!
    @IBOutlet weak var ganre_2: UILabel!
    @IBOutlet weak var ganre_3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
