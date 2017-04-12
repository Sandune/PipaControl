//
//  MyApplicationTableViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/20.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class MyApplicationTableViewCell: UITableViewCell {

    @IBOutlet weak var applicationTypeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var toTimeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = BG_COLOR
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
