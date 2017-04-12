//
//  EventsDetailViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/15.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class EventsDetailViewController: UIViewController,UIScrollViewDelegate {

    //滑动视图
    var detailScrollView:UIScrollView!
    
    //内容视图
    var contentView = UIView()
    
    //详情图片
    var detailImageView = UIImageView()
    
    //活动标题
    var titleLabel = UILabel()
    
    //活动时间
    var timeLabel = UILabel()
    
    //活动地点
    var spaceLabel = UILabel()
    
    //活动主持人
    var hostLabel = UILabel()
    
    //活动详情
    var detailLabel = UILabel()
    
    //报名参加
    var joinBtn = UIButton()
    
    //内容
    let str = "是附件文老师就放假了时间粉丝经济房安静王培荣颇为IP人品无人陪外婆软趴趴撒娇氨基酸大就是大解决大家速度解决啊觉得氨基酸大家氨基酸大时间段啊时间段件分类收集到了附近；圣诞节发生纠纷；升级到封建历史；的甲方设计的飞机；螺丝钉发酵饲料地方；螺丝钉解放；是垃圾地方就是大家法律上的飞机；"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "活动详情"
        
        
        detailScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        detailScrollView.delegate = self
        self.view.addSubview(detailScrollView)
        detailScrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
        
        contentView = UIView.init()
        contentView.backgroundColor = UIColor.white
        detailScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.height.equalTo(self.view)
        }
        
        detailImageView.contentMode = UIViewContentMode.scaleToFill
        detailImageView.image = UIImage(named: "info_border@2x")
        detailImageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3)
        contentView.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView).offset(0)
            make.height.equalTo(SCREEN_HEIGHT/3)
        }
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
        titleLabel.text = "谈天说地"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        timeLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
        timeLabel.text = "⏲ 时间:" + "2016-11-23 11:30"
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        spaceLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
        spaceLabel.text = "📍 空间:" + "火花餐厅"
        spaceLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(spaceLabel)
        spaceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        hostLabel.frame = CGRect(x: 10, y: 10, width: 0, height: 20)
        hostLabel.text = "🗿 主持人:" + "TT"
        hostLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(hostLabel)
        hostLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        let strHeight = heightSizeWithContent(content: str,widthSize:SCREEN_WIDTH-20, fontSize: 18).height
        
        detailLabel.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH-20, height:strHeight)
        detailLabel.text = str
        detailLabel.numberOfLines = 0
        //解决多行显示不全的问题
        detailLabel.adjustsFontSizeToFitWidth = true
        let attributedString = NSMutableAttributedString.init(string: str)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 6
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.characters.count))
        detailLabel.attributedText = attributedString
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(hostLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            //make.bottom.equalTo(joinBtn.snp.top).offset(-10)
            make.height.equalTo(strHeight)
            make.right.equalToSuperview().offset(-10)
        }
        
        joinBtn.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        joinBtn.setTitle("报名参加", for: .normal)
        joinBtn.backgroundColor = NAV_COLOR
        joinBtn.setTitleColor(.white, for: .normal)
        contentView.addSubview(joinBtn)
        joinBtn.addTarget(self, action: #selector(joinEvents), for: .touchUpInside)
        joinBtn.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        contentView.snp.removeConstraints()
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.equalTo(self.view)
            make.bottom.equalTo(joinBtn.snp.bottom).offset(20)
        }
        
    }

    
    
    func joinEvents(){
        print(contentView.frame.height)
        
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
