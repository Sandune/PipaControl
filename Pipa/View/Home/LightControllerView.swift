//
//  LightControllerView.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/5.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class LightControllerView: UIView {
    
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var controlBtn: UIButton!
    @IBOutlet weak var sendMsgBtn: UIButton!
    @IBOutlet weak var msgTextField: UITextField!
    
    @IBOutlet weak var roomTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sendMsgBtn.isHidden = true
        msgTextField.isHidden = true
        
        sendMsgBtn.layer.cornerRadius = 5
        
        let topOne = UITapGestureRecognizer(target: self, action: #selector(clickSelectBuild))
        
        buildingLabel.layer.borderWidth = 1
        buildingLabel.layer.cornerRadius = 5
        buildingLabel.layer.borderColor = BG_ORANGE.cgColor
        buildingLabel.isUserInteractionEnabled = true
        buildingLabel.addGestureRecognizer(topOne)
        
      
        roomTextField.layer.borderWidth = 1
        roomTextField.layer.cornerRadius = 5
        roomTextField.layer.borderColor = BG_ORANGE.cgColor
        roomTextField.isUserInteractionEnabled = true
        roomTextField.textAlignment = .center
        
        controlBtn.layer.cornerRadius = 25
    }
    
    func clickSelectBuild(){
        
        if buildingLabel.text == "p8" {
            buildingLabel.text = "northgate"
        }else{
            buildingLabel.text = "p8"
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
