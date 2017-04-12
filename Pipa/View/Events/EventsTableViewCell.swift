//
//  EventsTableViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/14.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var eventsTitleLabel: UILabel!
    @IBOutlet weak var thumbBtn: UIButton!
    @IBOutlet weak var eventsTimeBtn: UIButton!
    @IBOutlet weak var placeBtn: UIButton!
    @IBOutlet weak var hostBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        eventsView.layer.cornerRadius = 5
        eventsView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
