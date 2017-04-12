//
//  MyInfoModifyViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/28.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

protocol MyInfoModifyViewControllerDelegate{
    
    func changeData(model:String,indexRow:Int) -> Void
    
}

class MyInfoModifyViewController: UIViewController {

    var pageTitle:String!
    
    var contentStr:String!
    
    var index:Int!
    
    var textField = UITextField()
    
    var delegate:MyInfoModifyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pageTitle
        
        self.view.backgroundColor = BG_COLOR
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: .done, target: self, action: #selector(modifiedToComplete))
        
        createTextField()
        
    }
    
    func createTextField(){
        
        textField = UITextField.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.text = contentStr
        textField.textColor = .gray
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .unlessEditing
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
    }

    func modifiedToComplete(){
        self.delegate?.changeData(model: textField.text!, indexRow: index)
        _ = self.navigationController?.popViewController(animated: true)
        
        
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
