//
//  SpaceTableViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/7.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class SpaceTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!

    @IBOutlet weak var spaceImageView: UIImageView!
    
    @IBOutlet weak var spaceNameLabel: UILabel!
    
    @IBOutlet weak var spaceDetailLabel: UILabel!
    
    @IBOutlet weak var collectionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellContentView.clipsToBounds = true
        
        cellContentView.layer.cornerRadius = 5
        
        collectionBtn.setTitleColor(BG_ORANGE, for: .normal)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
