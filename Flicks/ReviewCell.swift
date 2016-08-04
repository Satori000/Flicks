//
//  ReviewCell.swift
//  Flicks
//
//  Created by Shakeeb Majid on 8/3/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    
    var review: NSDictionary?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
