//
//  MyTableHeaderView.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/14.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class MyTableHeaderView: UIView {

    @IBOutlet weak var headbgView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var translucentView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headbgView.layer.cornerRadius = 25.0
        headbgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        headbgView.layer.shadowOffset = CGSize(width: 0, height: 6)
        headbgView.layer.shadowOpacity = 1
        headbgView.layer.shadowRadius = 5
        
        headerImageView.layer.cornerRadius = 25.0
        headerImageView.layer.masksToBounds = true
        headerImageView.layer.borderColor = UIColor.white.cgColor
        headerImageView.layer.borderWidth = 1
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
