//
//  PostCell.swift
//  LinkedHouse
//
//  Created by Tribbianni_Sun on 5/3/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
