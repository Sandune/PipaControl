//
//  CustomStatusBar.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/6.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class CustomStatusBar: UIWindow {
    
    var topNotiLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIApplication.shared.statusBarFrame
        self.backgroundColor = BG_ORANGE
        self.windowLevel = UIWindowLevelStatusBar + 1.0
        
        topNotiLabel = UILabel.init(frame: CGRect(x: 10, y: 0, width: SCREEN_WIDTH, height: 20))
        topNotiLabel.font = UIFont.systemFont(ofSize: 10)
        topNotiLabel.textColor = .white
        self.addSubview(topNotiLabel)
        
        self.makeKeyAndVisible()
    }
    
    func showStatusMessage(message:String){
        
        self.isHidden = false
        self.alpha = 1.0
        topNotiLabel.text = ""
        
        let totalSize = self.frame.size
        self.frame = CGRect(origin:self.frame.origin, size: CGSize(width: totalSize.width, height: 0))
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.frame = CGRect(origin: self.frame.origin, size: totalSize)
        }) { (finished) in
            self.topNotiLabel.text = message
        }
        
    }
    
    func hide(){
        
        self.alpha = 1.0
        
        UIView.animate(withDuration: 3, animations: {
            self.alpha = 0
        }) { (finnished) in
            self.topNotiLabel.text = ""
            self.isHidden = true
        }
        
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

var topbarNotification:CustomStatusBar!
//MARK: - CustomStatusBar
func createTopBarNotification(msg:String){
    
    //如果存在就删除
    if topbarNotification != nil {
        topbarNotification?.removeFromSuperview()
    }
    //状态栏通知
    topbarNotification = CustomStatusBar.init(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: 20))
    UIApplication.shared.keyWindow?.bringSubview(toFront: topbarNotification!)
    topbarNotification!.showStatusMessage(message: msg)
}

func topBarNotificationHide(){
    topbarNotification.hide()
}
