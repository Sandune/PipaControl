//
//  HomeMyTableViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/21.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class HomeMyTableViewCell: UITableViewCell {
    @IBOutlet weak var myMessageLabel: UILabel!
    @IBOutlet weak var myHeadImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
