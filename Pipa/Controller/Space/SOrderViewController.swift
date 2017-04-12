//
//  SOrderViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/12.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class SOrderViewController: UIViewController,DatePickerViewDelegate,UIScrollViewDelegate {
    
    var orderScrollView:UIScrollView!
    
    var contentView:UIView!
    
    //空间照片
    var spaceImageView = UIImageView()
    
    //空间名字
    var spaceNameLabel = UILabel()
    
    //空间大小
    var spaceSizeLabel = UILabel()
    var spaceSize = "40"
    
    //时间选择器
    var datePicker = DatePickerView()
    
    //开始时间
    var startTimeLabel = UILabel()
    
    //结束时间
    var endTimeLabel = UILabel()
    
    //开始时间
    var startTimer:TimeInterval?
    
    //结束时间
    var endTimer:TimeInterval?
    
    //金额
    var costLabel = UILabel()
    
    //
    var costView = UIView()
    
    //总计金额
    var amountLabel = UILabel()
    var amountNumberLabel = UILabel()
    var amount:Double?
    
    //每平方日租金额度
    var rent = "1.2"
    
    //押金
    var deposit = "500"
    
    //支付按钮
    var rentBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "租用空间"
        
        creatUI()
        
        //添加KVO
        startTimeLabel.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        endTimeLabel.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        
    }
    
    //监听时间变化来计算金额
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if startTimer != nil && endTimer != nil {
            let value = endTimer! - startTimer!
            
            if value <= 0{
                rentBtn.setTitle("时间有误，请重新选择", for: .normal)
                buttonChangeState()
                amountNumberLabel.text = "  元"
                return
            }
            
            let day = Int(value)/(24 * 3600)
            amount = Double(day) * (Double(rent))! * Double(spaceSize)! + Double(deposit)!
            amountNumberLabel.text = "\(amount!)" + "元"
            
            rentBtn.backgroundColor = NAV_COLOR
            rentBtn.isUserInteractionEnabled = true
            rentBtn.setTitle("前往支付", for: .normal)
        }
        
    }
    
    deinit {
        startTimeLabel.removeObserver(self, forKeyPath: "text")
        endTimeLabel.removeObserver(self, forKeyPath: "text")
    }
    
    //MAKE - CreatUI
    func creatUI(){
        
        orderScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        orderScrollView.delegate = self
        self.view.addSubview(orderScrollView)
        orderScrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
        
        contentView = UIView.init()
        contentView.backgroundColor = UIColor.white
        orderScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.height.equalTo(self.view)
        }
        
        spaceImageView = UIImageView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3))
        spaceImageView.image = UIImage(named: "info_border@2x")
        contentView.addSubview(spaceImageView)
        spaceImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView).offset(0)
            make.height.equalTo(SCREEN_HEIGHT/3)
        }
        
        spaceNameLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "金字塔", fontSize: 18, textColor: .gray)
        contentView.addSubview(spaceNameLabel)
        spaceNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        spaceSizeLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "空间大小：" + "40" + "M²", fontSize: 14, textColor: .gray)
        contentView.addSubview(spaceSizeLabel)
        spaceSizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceNameLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        let startTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickSelectTime))
        
        startTimeLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "开始租用时间：点击选择开始时间", fontSize: 14, textColor: .gray)
        startTimeLabel.tag = 0
        startTimeLabel.isUserInteractionEnabled = true
        contentView.addSubview(startTimeLabel)
        startTimeLabel.addGestureRecognizer(startTapGestureRecognizer)
        startTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceSizeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        let endTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickSelectTime))
        
        endTimeLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "结束租用时间：点击选择结束时间", fontSize: 14, textColor: .gray)
        endTimeLabel.tag = 1
        endTimeLabel.isUserInteractionEnabled = true
        contentView.addSubview(endTimeLabel)
        endTimeLabel.addGestureRecognizer(endTapGestureRecognizer)
        endTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startTimeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        datePicker = DatePickerView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        datePicker.delegate = self
        
        costLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "每平米日租金：" + rent + "元" + "   " + "押金：" + deposit + "元", fontSize: 12, textColor: NAV_COLOR)
        contentView.addSubview(costLabel)
        costLabel.snp.makeConstraints { (make) in
            make.top.equalTo(endTimeLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        costView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-20, height: 540))
        costView.backgroundColor = UIColor.white
        costView.layer.borderWidth = 1
        costView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(costView)
        costView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(costLabel.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        amountLabel.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        amountLabel.textColor = BG_ORANGE
        amountLabel.text = "总金额："
        amountLabel.font = UIFont.systemFont(ofSize: 18)
        amountLabel.textAlignment = .right
        costView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(25)
            make.width.equalTo(costView.frame.width/2)
            make.left.equalToSuperview().offset(10)
        }
        
        amountNumberLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        amountNumberLabel.textColor = NAV_COLOR
        amountNumberLabel.text = "请选择时间"
        amountNumberLabel.font = UIFont.systemFont(ofSize: 16)
        costView.addSubview(amountNumberLabel)
        amountNumberLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(25)
            make.left.equalTo(costView.frame.width/2)
        }
        
        rentBtn.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH-20, height: 40)
        rentBtn.setTitle("请选择时间", for: .normal)
        buttonChangeState()
        rentBtn.addTarget(self, action: #selector(rentSpace), for: .touchDown)
        contentView.addSubview(rentBtn)
        rentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(costView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        contentView.snp.removeConstraints()
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.equalTo(self.view)
            make.bottom.equalTo(costView.snp.bottom).offset(20)
        }

    }
    
    func buttonChangeState(){
        
        rentBtn.backgroundColor = .gray
        rentBtn.isUserInteractionEnabled = false
        
    }
    
    
    //MARK - DatePickerViewDelegate
    
    var clickThe = Int()
    
    func clickSelectTime(sender:UITapGestureRecognizer){
        
        self.navigationController?.view.addSubview(datePicker)
        
        clickThe = sender.view!.tag
        
        datePicker.openPickerViewAnimation()
        
    }
    
    func getUserSelectedValue(timeStr:String , timeDate:TimeInterval) {
        
        if clickThe == 0 {
            startTimer = timeDate
            startTimeLabel.text = "开始租用时间："+timeStr
        }else if clickThe == 1{
            endTimer = timeDate
            endTimeLabel.text = "结束租用时间："+timeStr
        }
        
    }
    
    func rentSpace(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
