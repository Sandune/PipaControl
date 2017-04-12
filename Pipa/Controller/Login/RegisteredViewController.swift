//
//  RegisteredViewController.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/10.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class RegisteredViewController: UIViewController,UITextFieldDelegate {

    var userNameTextField:UITextField!
    
    var passwordTextField:UITextField!
    
    var inputAgainTextField:UITextField!
    
    var registeredBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账号注册"
        
        userNameTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        userNameTextField.placeholder = "请输入手机号"
        userNameTextField.font = LARGE_FONT
        userNameTextField.keyboardType = .numberPad
        userNameTextField.delegate = self
        userNameTextField.clearButtonMode = .whileEditing
        self.view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalToSuperview().offset(124)
        }
        
        let lineColor = UIColor.init(red: 209/255, green: 209/255, blue: 211/255, alpha: 1)
        
        let oneLine = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        oneLine.backgroundColor = lineColor
        self.view.addSubview(oneLine)
        oneLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(userNameTextField.snp.bottom).offset(0)
        }
        
        passwordTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.font = LARGE_FONT
        passwordTextField.delegate = self
        passwordTextField.clearButtonMode = .whileEditing
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(oneLine.snp.bottom).offset(0)
        }
        
        let twoLine = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        twoLine.backgroundColor = lineColor
        self.view.addSubview(twoLine)
        twoLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(passwordTextField.snp.bottom).offset(0)
        }
        
        inputAgainTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        inputAgainTextField.isSecureTextEntry = true
        inputAgainTextField.placeholder = "再次输入密码"
        inputAgainTextField.font = LARGE_FONT
        inputAgainTextField.delegate = self
        inputAgainTextField.clearButtonMode = .whileEditing
        self.view.addSubview(inputAgainTextField)
        inputAgainTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(twoLine.snp.bottom).offset(0)
        }
        
        let threeLine = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        threeLine.backgroundColor = lineColor
        self.view.addSubview(threeLine)
        threeLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(inputAgainTextField.snp.bottom).offset(0)
        }
        
        registeredBtn = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "注册", titleColor: NAV_COLOR, titleSize: 14, target: self, action: #selector(userRegister), touch: .touchUpInside)
        registeredBtn.layer.borderWidth = 1
        registeredBtn.layer.borderColor = lineColor.cgColor
        self.view.addSubview(registeredBtn)
        registeredBtn.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(threeLine.snp.bottom).offset(60)
        }

        // Do any additional setup after loading the view.
    }
    
    func userRegister(){
        
        let isRight = checkTelNumber(telNumber: userNameTextField.text!)

        if userNameTextField.text == "" {
            createTopBarNotification(msg:"请输入手机号")
        }else if(!isRight){
            createTopBarNotification(msg:"手机号格式错误")
        }else if passwordTextField.text == "" {
            createTopBarNotification(msg:"请输入密码")
        }else if passwordTextField.text!.characters.count < 6 {
            createTopBarNotification(msg:"密码必须超过或等于6位数")
        }else if passwordTextField.text == "123456" {
            createTopBarNotification(msg:"密码过于简单")
        }else if inputAgainTextField.text == "" {
            createTopBarNotification(msg:"请再次输入密码")
        }else if passwordTextField.text != inputAgainTextField.text{
            createTopBarNotification(msg:"密码不一致")
        }else{
        
        }
        topBarNotificationHide()
    
    }
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        let toBeStr = nsString?.replacingCharacters(in: range, with: string) as NSString?
        
        if textField == userNameTextField {
            if toBeStr!.length > 11 && range.length != 1 {
                textField.text = toBeStr!.substring(to: 11)
                return false
            }
        }
        
        if textField == passwordTextField || textField == inputAgainTextField {
            if toBeStr!.length > 20 && range.length != 1 {
                textField.text = toBeStr!.substring(to: 20)
                return false
            }
        }
        
        return true
        
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
