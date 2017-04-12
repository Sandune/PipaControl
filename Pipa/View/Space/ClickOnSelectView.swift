//
//  ClickOnSelectView.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/7.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

protocol ClickOnSelectViewDelegate {
    func clickOnSelectView(sender:UIButton)
}

class ClickOnSelectView: UIView {
    
    var mapBtn = UIButton()
    
    var spaceBtn = UIButton()
    
    var delegate: ClickOnSelectViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置阴影以及背景
        self.backgroundColor = UIColor.white
        
        self.layer.shadowColor = UIColor.init(red: 174/255, green: 174/255, blue: 174/255, alpha: 1).cgColor
        
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        self.layer.shadowOpacity = 0.5
        
        //中间线
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 30))
        
        lineView.backgroundColor = UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        
        lineView.center = CGPoint(x: SCREEN_WIDTH/4, y: 20)
        
        self.addSubview(lineView)
        
        //左边地图按钮
        mapBtn = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/4, height: 40), title: "地图", titleColor: NAV_COLOR, titleSize: 18, target: self, action:#selector(selectWithView),touch:.touchDown)
        
        mapBtn.tag = 0
        
        self.addSubview(mapBtn)
        
        //右边空间按钮
        spaceBtn = Utilitys.createBtnString(frame: CGRect(x: SCREEN_WIDTH/4, y: 0, width: SCREEN_WIDTH/4, height: 40), title: "空间", titleColor: NAV_COLOR, titleSize: 18, target: self, action:#selector(selectWithView),touch:.touchDown)
        spaceBtn.tag = 1
        
        self.addSubview(spaceBtn)
        
        
    }
    
    func selectWithView(sender:UIButton){
        if sender.tag == 0 {
            
            mapBtn.setTitleColor(UIColor.gray, for: .normal)
            
            spaceBtn.setTitleColor(NAV_COLOR, for: .normal)
            
            delegate?.clickOnSelectView(sender:mapBtn)
            
        }else if sender.tag == 1{
            
            mapBtn.setTitleColor(NAV_COLOR, for: .normal)
            
            spaceBtn.setTitleColor(UIColor.gray, for: .normal)
            
            delegate?.clickOnSelectView(sender:spaceBtn)
            
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
