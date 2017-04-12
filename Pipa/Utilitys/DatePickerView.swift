//
//  DatePickerView.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/13.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func getUserSelectedValue(timeStr:String , timeDate:TimeInterval)
}

class DatePickerView: UIView {
    
    var animationView = UIView()
    
    var datePicker = UIDatePicker()
    
    var determineBtn = UIButton()
    
    var cancelBtn = UIButton()
    
    var timer = String()
    
    var timerDate = TimeInterval()
    
    var delegate:DatePickerViewDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)

        animationView = UIView.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 260))
        animationView.backgroundColor = UIColor.white
        self.addSubview(animationView)
        
        determineBtn = UIButton.init(frame: CGRect(x: SCREEN_WIDTH-90, y: 10, width: 80, height: 22))
        determineBtn.tag = 1
        determineBtn.setTitle("确定", for: .normal)
        changeState()
        determineBtn.addTarget(self, action: #selector(whetherDetermineTheTime), for: .touchUpInside)
        animationView.addSubview(determineBtn)
        
        cancelBtn = UIButton.init(frame: CGRect(x: 10, y: 10, width: 80, height: 20))
        cancelBtn.tag = 0
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.backgroundColor = UIColor.blue
        cancelBtn.addTarget(self, action: #selector(whetherDetermineTheTime), for: .touchUpInside)
        animationView.addSubview(cancelBtn)
        
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 30, width: SCREEN_WIDTH, height: 230))
        animationView.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(dateChangeAction(sender:)), for: .valueChanged)
        datePicker.locale = NSLocale.init(localeIdentifier: "zh_CN") as Locale
        
    }
    
    func openPickerViewAnimation(){
        UIView.animate(withDuration: 0.4) {
            var rect = self.animationView.frame
            rect.origin.y = SCREEN_HEIGHT-260
            self.animationView.frame = rect
        }
    }
    
    func whetherDetermineTheTime(sender:UIButton) -> String{
        
        UIView.animate(withDuration: 0.4, animations: {
            var rect = self.animationView.frame
            rect.origin.y = SCREEN_HEIGHT-260
            self.animationView.frame = rect
            }, completion: { (finished) in
                self.removeFromSuperview()
        })
        
        switch sender.tag {
        case 0:
            
            changeState()
            
            return ""
            
        case 1:
            
            delegate?.getUserSelectedValue(timeStr: timer , timeDate: timerDate)
            
            changeState()
            
            return timer
            
        default:
            break
        }
        
        
       return ""
    }
    
    func changeState(){
        
        determineBtn.isUserInteractionEnabled = false
        
        determineBtn.backgroundColor = .gray
        
    }
    
    func dateChangeAction(sender:UIDatePicker){
        
        if determineBtn.isUserInteractionEnabled == false {
            
            determineBtn.isUserInteractionEnabled = true
            
            determineBtn.backgroundColor = .blue
        
        }
        
        let control = sender
        
        control.minimumDate = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YY-MM-dd HH:mm"
        
        timer = dateFormatter.string(from: sender.date)
        
        timerDate = sender.date.timeIntervalSince1970
        
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
