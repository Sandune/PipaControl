//
//  SwiftTest.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/6.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import KeychainSwift

let SCREEN_WIDTH = UIScreen.main.bounds.width

let SCREEN_HEIGHT = UIScreen.main.bounds.height

let BG_COLOR = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)

let BG_ORANGE = UIColor.init(red: 234/255, green: 84/255, blue: 20/255, alpha: 1)

let BG_YELLOW = UIColor.init(red: 246/255, green: 172/255, blue: 24/255, alpha: 1)

let NAV_COLOR = UIColor.init(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)

let SMALL_FONT = UIFont.systemFont(ofSize: 10)

let MEDIUM_FONT = UIFont.systemFont(ofSize: 12)

let LARGE_FONT = UIFont.systemFont(ofSize: 14)

let MAX_FONT = UIFont.systemFont(ofSize: 18)

let SEVER_IP = "url"

//计算文字高度
func heightSizeWithContent(content:String,widthSize:CGFloat,fontSize:Int) -> CGSize{
    
    let contentSize = content.boundingRect(with: CGSize(width:widthSize,
                                                        height:CGFloat(MAXFLOAT)),
                                           options:.usesLineFragmentOrigin,
                                           attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: CGFloat(fontSize))],
                                           context: nil).size
    
    return contentSize
}

//剥出文字中的数字
func extractTheNumberInTheText(str:String) -> Int{
    
    var number = 0
    let scanner = Scanner.init(string: str)
    scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
    scanner.scanInt(&number)
    
    return number
}

//正则判断手机号
func checkTelNumber(telNumber:String) -> Bool{
    
    let pattern = "^1+[3578]+\\d{9}"
    let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
    let isMatch = pred.evaluate(with: telNumber)
    
    return isMatch
}

//判断时间差以及是否是同一天
func timeToDetermine(nowDate:Date,beforeDate:Date) -> Bool{
    
    //开始比较
    if Calendar.current.isDate(nowDate, inSameDayAs: beforeDate) {
        //它们是同一天
        
        //获取两个时间差
        let diffComponents = Calendar.current.dateComponents([Calendar.Component.hour], from: beforeDate, to: nowDate)
        
        if diffComponents.hour! >= 5 {
            return true
        }
        return false
        
    }else {
        
        //它们不是同一天
        return true
        
    }
    
}









