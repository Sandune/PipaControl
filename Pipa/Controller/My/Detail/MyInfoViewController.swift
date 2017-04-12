//
//  MyInfoViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/20.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MyInfoModifyViewControllerDelegate {
    
    var infoTableView = UITableView()
    
    var listName = ["头像","姓名","性别","邮箱","地区"]
    
    var userInfo:[String] = ["","景川","男","827299862@qq.com","湖南-益阳"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        createTableView()
    
    }
    
    func createTableView(){
        
        infoTableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.backgroundColor = BG_COLOR
        infoTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        let cellNib = UINib(nibName: "MyInfoTableViewCell", bundle: nil)
        infoTableView.register(cellNib, forCellReuseIdentifier: "headCell")
        infoTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        self.view.addSubview(infoTableView)
        infoTableView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        }
    }

    //MARK: - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {return 85}
        
        return 45
    }
    
    //设置每一节多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listName.count
    }
    
    //渲染cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "cell"
        
        if indexPath.row == 0 {
            let identifier = "headCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyInfoTableViewCell
            
            cell.textLabel?.text = "头像"
            
            return cell
        }
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: identifier)
        
        cell.selectionStyle = .none
        
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = listName[indexPath.row]
        
        if indexPath.row != 0 {
        
            cell.detailTextLabel?.text = userInfo[indexPath.row]
        
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        }else{
            //向下级界面传值
            let modifyVC = MyInfoModifyViewController.init(nibName: "MyInfoModifyViewController" , bundle: nil)
            modifyVC.pageTitle = listName[indexPath.row]
            modifyVC.contentStr = userInfo[indexPath.row]
            modifyVC.index = indexPath.row
            modifyVC.delegate = self
            self.navigationController?.pushViewController(modifyVC, animated: true)
            
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeData(model:String,indexRow:Int) -> Void{
        
        self.userInfo[indexRow] = model
        
        //swift刷新某一行
        let indexPath = IndexPath.init(row: indexRow, section: 0)
        
        self.infoTableView.reloadRows(at: [indexPath], with: .none)

    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
}
