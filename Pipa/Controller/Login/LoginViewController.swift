//
//  LoginViewController.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/10.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit
import KeychainSwift

protocol LoginViewControllerDelegate{
    
    func reloadView() -> Void

    
}

class LoginViewController: UIViewController,UITextFieldDelegate {

    //输入用户名
    var userNameTextField:UITextField!
    //密码框
    var passwordTextField:UITextField!
    //登录按钮
    var loginBtn:UIButton!
    //注册按钮
    var registeredBtn:UIButton!
    //忘记密码
    var forgetPasswordBtn:UIButton!
    //微博登录
    var weboBtn:UIButton!
    //QQ登录
    var qqBtn:UIButton!
    //微信登录
    var weChatBtn:UIButton!
    
    var delegate:LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "账号登录"
        
        createUI()
        
        // Do any additional setup after loading the view.
    }
    
    func createUI(){
        
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
        
        forgetPasswordBtn = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "忘记密码？", titleColor: NAV_COLOR, titleSize: 10, target: self, action: #selector(loginAction), touch: .touchUpInside)
        self.view.addSubview(forgetPasswordBtn)
        forgetPasswordBtn.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(60)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(twoLine.snp.bottom).offset(5)
        }
        
        loginBtn = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "登录", titleColor: .white, titleSize: 14, target: self, action: #selector(loginAction), touch: .touchUpInside)
        loginBtn.backgroundColor = NAV_COLOR
        self.view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(forgetPasswordBtn.snp.bottom).offset(30)
        }
        
        registeredBtn = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "注册", titleColor: NAV_COLOR, titleSize: 14, target: self, action: #selector(pushRegistered), touch: .touchUpInside)
        registeredBtn.layer.borderWidth = 1
        registeredBtn.layer.borderColor = lineColor.cgColor
        self.view.addSubview(registeredBtn)
        registeredBtn.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
        }
        
        qqBtn = Utilitys.createBtnImage(frame: CGRect(x: 0, y: 0, width: 0, height: 0), image: #imageLiteral(resourceName: "qq"), target: self, action: #selector(thirdPartyInterface), touch: .touchUpInside)
        self.view.addSubview(qqBtn)
        qqBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        weChatBtn = Utilitys.createBtnImage(frame: CGRect(x: 0, y: 0, width: 0, height: 0), image: #imageLiteral(resourceName: "weixin"), target: self, action: #selector(thirdPartyInterface), touch: .touchUpInside)
        self.view.addSubview(weChatBtn)
        weChatBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.centerY.equalTo(qqBtn.snp.centerY)
            make.left.equalTo(qqBtn.snp.right).offset(30)
        }
        
        weboBtn = Utilitys.createBtnImage(frame: CGRect(x: 0, y: 0, width: 0, height: 0), image: #imageLiteral(resourceName: "weibo"), target: self, action: #selector(thirdPartyInterface), touch: .touchUpInside)
        self.view.addSubview(weboBtn)
        weboBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.centerY.equalTo(qqBtn.snp.centerY)
            make.right.equalTo(qqBtn.snp.left).offset(-30)
        }
        
        let plaLabel = Utilitys.createLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "使用社交账号", fontSize: 10, textColor: NAV_COLOR, textAlignment: .center, numberOfLines: 1)
        self.view.addSubview(plaLabel!)
        plaLabel?.snp.makeConstraints { (make) in
            make.centerX.equalTo(qqBtn.snp.centerX)
            make.height.equalTo(14)
            make.bottom.equalTo(qqBtn.snp.top).offset(-32)
        }
        
        let leftLine = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        leftLine.backgroundColor = NAV_COLOR
        self.view.addSubview(leftLine)
        leftLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(26)
            make.right.equalTo(plaLabel!.snp.left).offset(-8)
            make.centerY.equalTo(plaLabel!.snp.centerY)
        }
        
        let rightLine = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        rightLine.backgroundColor = NAV_COLOR
        self.view.addSubview(rightLine)
        rightLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.right.equalToSuperview().offset(-26)
            make.left.equalTo(plaLabel!.snp.right).offset(8)
            make.centerY.equalTo(plaLabel!.snp.centerY)
        }
        
    }
    
    func thirdPartyInterface(){
        
    }
    
    func loginAction(){
        
        //存储密码
//        let keychain = KeychainSwift()
//        keychain.set(userNameTextField.text!, forKey: "userAccount")
//        keychain.set(passwordTextField.text!, forKey: "userPassword")

        UserDefaults.standard.set(true, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        self.delegate?.reloadView()
        _ = self.navigationController?.popViewController(animated: true)
        
    }

    func pushRegistered(){
        
        let registVC = RegisteredViewController.init(nibName: "RegisteredViewController", bundle: nil)
        
        self.navigationController?.pushViewController(registVC, animated: true)
        
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
        
        if textField == passwordTextField {
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
