//
//  Utilitys.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/17.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class Utilitys: NSObject {
    
    //只含文字的按钮
    static func createBtnString(frame:CGRect,title:String,titleColor:UIColor,titleSize:Int,target:AnyObject?,action:Selector,touch:UIControlEvents) -> UIButton!{
        
        let btn:UIButton!
        btn = UIButton.init(frame: frame)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: CGFloat(titleSize))
        btn.addTarget(target, action: action, for: touch)
        
        return btn
    }
    
    //含图片的按钮
    static func createBtnImage(frame:CGRect,image:UIImage,target:AnyObject?,action:Selector,touch:UIControlEvents) -> UIButton!{
        
        let btn:UIButton!
        btn = UIButton.init(frame: frame)
        btn.setImage(image, for: .normal)
        btn.addTarget(target, action: action, for: touch)
     
        return btn
    }
    
    
    static func createLabel(frame:CGRect,text:String,fontSize:Int,textColor:UIColor,textAlignment:NSTextAlignment,numberOfLines:Int) -> UILabel!{
        
        let label:UILabel!
        label = UILabel.init(frame: frame)
        label.text = text
        label.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
    
    static func createLabel(frame:CGRect,text:String,fontSize:Int,textColor:UIColor) -> UILabel!{
        let label:UILabel!
        label = UILabel.init(frame: frame)
        label.text = text
        label.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        label.textColor = textColor
        return label
    }
}
