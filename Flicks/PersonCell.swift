//
//  PersonCell.swift
//  Flicks
//
//  Created by Shakeeb Majid on 8/3/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var actorPhotoView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
