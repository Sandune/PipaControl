//
//  SDetailViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/8.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit
import Alamofire

class SDetailViewController: UIViewController,UIScrollViewDelegate {
    //空间详情
    //上级传递
    var detailDic:NSDictionary!
    //当前加载
    var spaceDetail = NSDictionary()
    //滑动视图
    var detailScrollView:UIScrollView!
    //内容视图
    var contentView:UIView!
    //空间照片
    var spaceImageView = UIImageView()
    //空间名
    var titleLabel = UILabel()
    //空间大小
    var spaceSizeLabel = UILabel()
    //空间最大容纳人数
    var spacePeopleNumberLabel = UILabel()
    //空间位置
    var spacelocationLabel = UILabel()
    //空间详情
    var detailLabel = UILabel()
    //点击租用
    var rentBtn = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "空间详情"
        
        createUI()
        getSpaceDetail()
        
    }
    
    func getSpaceDetail(){
        
        Alamofire.request(SEVER_IP + "url",
                          method: .get).responseJSON { (response) in
                            
                            let arr:Array<NSDictionary> = response.result.value as! Array
                            
                            self.spaceDetail = arr[0]
                            
                            self.titleLabel.text = (self.detailDic["name"] as! String)
                            
                            self.spaceSizeLabel.text = "空间大小：\(self.spaceDetail["area"]!) ㎡"
                            
                            self.spacePeopleNumberLabel.text = "空间最大容纳人数：\(self.spaceDetail["max_capacity"]!) 人"
                            
                            self.spacelocationLabel.text = "空间位置："+(self.spaceDetail["building_name"] as? String)!+"  \(self.spaceDetail["room"]!)"
        }
        
    }
    
    func createUI(){
        
        let detail = detailDic["details"] as? String
        
        detailScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        detailScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 0)
        detailScrollView.backgroundColor = BG_COLOR
        detailScrollView.delegate = self
        self.view.addSubview(detailScrollView)
        detailScrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
        
        contentView = UIView.init()
        contentView.backgroundColor = BG_COLOR
        detailScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.height.equalTo(self.view)
        }
        
        let url = URL(string: SEVER_IP + (detailDic["headimg"] as! String))
        
        spaceImageView.contentMode = UIViewContentMode.scaleToFill
        spaceImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "imgbad"), options: nil, progressBlock: nil, completionHandler: nil)
        spaceImageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3)
        spaceImageView.backgroundColor = .white
        contentView.addSubview(spaceImageView)
        spaceImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView).offset(0)
            make.height.equalTo(SCREEN_HEIGHT/3)
        }
        
        titleLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "", fontSize: 18, textColor: NAV_COLOR)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        spaceSizeLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "", fontSize: 12, textColor: .gray)
        contentView.addSubview(spaceSizeLabel)
        spaceSizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(15)
        }
        
        spacelocationLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "", fontSize: 12, textColor: .gray)
        contentView.addSubview(spacelocationLabel)
        spacelocationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceSizeLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(15)
        }
        
        spacePeopleNumberLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "", fontSize: 12, textColor: .gray)
        contentView.addSubview(spacePeopleNumberLabel)
        spacePeopleNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spacelocationLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(15)
        }
        
        let strHeight = heightSizeWithContent(content: detail!,widthSize:SCREEN_WIDTH-20, fontSize: 18).height
        detailLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-20, height:strHeight+20), text: detail!, fontSize: 14, textColor: NAV_COLOR, textAlignment: .left, numberOfLines: 0)
        //解决多行显示不全的问题
        detailLabel.adjustsFontSizeToFitWidth = true
        let attributedString = NSMutableAttributedString.init(string: detail!)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 6
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, detail!.characters.count))
        detailLabel.attributedText = attributedString
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(spacePeopleNumberLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(strHeight)
            make.right.equalToSuperview().offset(-10)
        }
        
        rentBtn = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-20, height: 40), title: "租用空间", titleColor: .white, titleSize: 16, target: self, action: #selector(rentSpace(sender:)), touch: .touchDown)
        rentBtn.isHidden = true
        contentView.addSubview(rentBtn)
        rentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        contentView.snp.removeConstraints()
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.equalTo(self.view)
            make.bottom.equalTo(rentBtn.snp.bottom).offset(20)
        }

    }
    
    func rentSpace(sender:UIButton){
        self.performSegue(withIdentifier: "showOrder", sender: nil)
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
