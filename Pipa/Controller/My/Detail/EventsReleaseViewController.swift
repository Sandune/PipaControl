//
//  EventsReleaseViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/19.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

import AVFoundation

import Photos

class EventsReleaseViewController: UIViewController,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DatePickerViewDelegate {

    
    //滑动视图
    var releaseScrollView = UIScrollView()
    
    //内容视图
    var contentView = UIView()
    
    //点击图片显示
    var selecterImageView = UIImageView()
    
    var sourceType = UIImagePickerControllerSourceType.photoLibrary//将sourceType赋一个初值类型，防止调用时不赋值出现崩溃
    
    var alertController = UIAlertController()
    
    //提示字
    var promptLabel = UILabel()
    
    //活动名字
    var titleTextField = UITextField()
    
    //开始时间
    var fromTimeLabel = UILabel()
    
    var datePicker = DatePickerView()
    
    //结束时间
    var toTimeLabel = UILabel()
    
    //活动地点
    var placeTextField = UITextField()
    
    //内容简介
    var detailTextView = UITextView()
    
    //内容链接
    var urlTextField = UITextField()
    
    //票价
    var priceTextField = UITextField()
    
    //总票量
    var priceNumberTextField = UITextField()
    
    //报名期限
    var registrationDeadlineTextField = UITextField()
    
    //每人限购
    var purchasingTextField = UITextField()
    
    //人数限制
    var peopleNumberTextField = UITextField()
    
    //发布活动
    var releaseBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布活动"
        
        releaseScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        releaseScrollView.delegate = self
        self.view.addSubview(releaseScrollView)
        releaseScrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
        
        contentView = UIView.init()
        contentView.backgroundColor = BG_COLOR
        releaseScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.height.equalTo(self.view)
        }
        
        let selecterTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        selecterImageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        selecterImageView.image = #imageLiteral(resourceName: "info_border@2x")
        selecterImageView.isUserInteractionEnabled = true
        contentView.addSubview(selecterImageView)
        selecterImageView.addGestureRecognizer(selecterTapGestureRecognizer)
        selecterImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0)
            make.height.equalTo(SCREEN_HEIGHT/3)
        }
        
        promptLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        promptLabel.text = "* 点击图片来选择"
        promptLabel.textColor = .red
        promptLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.top.equalTo(selecterImageView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(15)
        }
        
        titleTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        titleTextField.placeholder = "请填写活动名称!"
        titleTextField.font = UIFont.systemFont(ofSize: 14)
        titleTextField.layer.borderWidth = 1
        titleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        titleTextField.leftViewMode = .always
        titleTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(promptLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        let fromTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickSelectTime))
        
        fromTimeLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        fromTimeLabel.text = "开始时间:" + "点击选择"
        fromTimeLabel.font = UIFont.systemFont(ofSize: 14)
        fromTimeLabel.layer.borderWidth = 1
        fromTimeLabel.layer.borderColor = NAV_COLOR.cgColor
        fromTimeLabel.textColor = NAV_COLOR
        contentView.addSubview(fromTimeLabel)
        fromTimeLabel.addGestureRecognizer(fromTapGestureRecognizer)
        fromTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        let toTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickSelectTime))
        
        toTimeLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        toTimeLabel.text = "结束时间:" + "点击选择"
        toTimeLabel.font = UIFont.systemFont(ofSize: 14)
        toTimeLabel.layer.borderWidth = 1
        toTimeLabel.layer.borderColor = NAV_COLOR.cgColor
        toTimeLabel.textColor = NAV_COLOR
        contentView.addSubview(toTimeLabel)
        toTimeLabel.addGestureRecognizer(toTapGestureRecognizer)
        toTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fromTimeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        placeTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        placeTextField.placeholder = "输入活动地点"
        placeTextField.font = UIFont.systemFont(ofSize: 14)
        placeTextField.layer.borderWidth = 1
        placeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        placeTextField.leftViewMode = .always
        placeTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(placeTextField)
        placeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(toTimeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        detailTextView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        detailTextView.font = UIFont.systemFont(ofSize: 14)
        detailTextView.backgroundColor = BG_COLOR
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(detailTextView)
        detailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(placeTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(100)
        }
        
        urlTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        urlTextField.placeholder = "输入活动相关链接"
        urlTextField.font = UIFont.systemFont(ofSize: 14)
        urlTextField.layer.borderWidth = 1
        urlTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        urlTextField.leftViewMode = .always
        urlTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(urlTextField)
        urlTextField.snp.makeConstraints { (make) in
            make.top.equalTo(detailTextView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        priceTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        priceTextField.placeholder = "票价:￥/份"
        priceTextField.font = UIFont.systemFont(ofSize: 14)
        priceTextField.layer.borderWidth = 1
        priceTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        priceTextField.leftViewMode = .always
        priceTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(priceTextField)
        priceTextField.snp.makeConstraints { (make) in
            make.top.equalTo(urlTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        priceNumberTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        priceNumberTextField.placeholder = "售票量:？张"
        priceNumberTextField.font = UIFont.systemFont(ofSize: 14)
        priceNumberTextField.layer.borderWidth = 1
        priceNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        priceNumberTextField.leftViewMode = .always
        priceNumberTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(priceNumberTextField)
        priceNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(priceTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        registrationDeadlineTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        registrationDeadlineTextField.placeholder = "报名期限:？天"
        registrationDeadlineTextField.font = UIFont.systemFont(ofSize: 14)
        registrationDeadlineTextField.layer.borderWidth = 1
        registrationDeadlineTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        registrationDeadlineTextField.leftViewMode = .always
        registrationDeadlineTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(registrationDeadlineTextField)
        registrationDeadlineTextField.snp.makeConstraints { (make) in
            make.top.equalTo(priceNumberTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        purchasingTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        purchasingTextField.placeholder = "每人限购: ？/张"
        purchasingTextField.font = UIFont.systemFont(ofSize: 14)
        purchasingTextField.layer.borderWidth = 1
        purchasingTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        purchasingTextField.leftViewMode = .always
        purchasingTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(purchasingTextField)
        purchasingTextField.snp.makeConstraints { (make) in
            make.top.equalTo(registrationDeadlineTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        peopleNumberTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        peopleNumberTextField.placeholder = "设定最低参与人数，低于最低人数取消该活动（可选）"
        peopleNumberTextField.font = UIFont.systemFont(ofSize: 14)
        peopleNumberTextField.layer.borderWidth = 1
        peopleNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        peopleNumberTextField.leftViewMode = .always
        peopleNumberTextField.layer.borderColor = NAV_COLOR.cgColor
        contentView.addSubview(peopleNumberTextField)
        peopleNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(purchasingTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        releaseBtn.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        releaseBtn.setTitle("发布活动", for: .normal)
        releaseBtn.backgroundColor = NAV_COLOR
        releaseBtn.tintColor = .white
        contentView.addSubview(releaseBtn)
        releaseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(peopleNumberTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        
        contentView.snp.removeConstraints()
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().offset(0)
            make.width.equalTo(self.view)
            make.bottom.equalTo(releaseBtn.snp.bottom).offset(20)
        }
        
    }

    
    //MARK: - selectImageDlegate
    
    /*
     判断相机相册访问权限
     
     有权限：retrun true
     无权限：return false
     */
    
    func cameraPerimissons() -> Bool{
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if authStatus == .denied || authStatus == .restricted {
            return false
        }else{
            return true
        }
    }
    
    func photoLibraryPerimissons() -> Bool{
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if library == .denied || library == .restricted {
            return false
        }else{
            return true
        }
    }
    
    func open(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: {
            
        })
    }
    
    func selectImage(){
        
        let camera = "相机"
        let photoAlbm = "打开相册"
        let cancel = "取消"
        
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let openCamera = UIAlertAction.init(title: camera, style: .default) { (action) in
            
            if self.cameraPerimissons() == true{
                
                self.sourceType = .camera
                self.open()
            
            }else{
                
                self.alertController = UIAlertController.init(title: nil, message: "请在设置中打开相机权限", preferredStyle: .alert)
                
                let tempAction = UIAlertAction.init(title: "确定", style: .cancel, handler: { (action) in
                    
                })
                
                self.alertController.addAction(tempAction)
                self.present(self.alertController, animated: true, completion: nil)
                
            }
            
            
        }
        
        let openPhotoAlbm = UIAlertAction.init(title: photoAlbm, style: .destructive) { (action) in
            
            if self.photoLibraryPerimissons() == true{
                self.sourceType = .photoLibrary
                self.open()
            }else{
                self.alertController = UIAlertController.init(title: nil, message: "请在设置中打开相册权限", preferredStyle: .alert)
                
                let tempAction = UIAlertAction.init(title: "确定", style: .cancel, handler: { (action) in
                    
                })
                
                self.alertController.addAction(tempAction)
                self.present(self.alertController, animated: true, completion: nil)
            }
        }
        
        let cancelBtn = UIAlertAction.init(title: cancel, style: .cancel) { (action) in
            
        }
        
        alertController.addAction(openCamera)
        alertController.addAction(openPhotoAlbm)
        alertController.addAction(cancelBtn)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage]
        
        picker.dismiss(animated: true) { 
            self.selecterImageView.image = image as! UIImage?
        }
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
            fromTimeLabel.text = "开始租用时间："+timeStr
        }else if clickThe == 1{
            toTimeLabel.text = "结束租用时间："+timeStr
        }
        
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
