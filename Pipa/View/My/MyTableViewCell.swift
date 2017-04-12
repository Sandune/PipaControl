//
//  MyTableViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/14.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var listIconImageView: UIImageView!
    @IBOutlet weak var listNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
