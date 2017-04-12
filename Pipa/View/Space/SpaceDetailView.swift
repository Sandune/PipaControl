//
//  SpaceDetailView.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/9.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class SpaceDetailView: UIView {
    
    var titleLabel = UILabel()
    
    var detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = Utilitys.createLabel(frame: CGRect(x: 10, y: 10, width: SCREEN_WIDTH-20, height: 20), text: "", fontSize: 20, textColor: .black)

        self.addSubview(titleLabel)
        
        detailLabel = Utilitys.createLabel(frame: CGRect(x: 10, y: 40, width: SCREEN_WIDTH-20, height: 0), text: "", fontSize: 15, textColor: .gray, textAlignment: .left, numberOfLines: 0)
        
        self.addSubview(detailLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
