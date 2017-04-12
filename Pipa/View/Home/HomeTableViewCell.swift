//
//  HomeTableViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/21.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var heimuMessageLabel: UILabel!
    
    @IBOutlet weak var heimuHeadImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
