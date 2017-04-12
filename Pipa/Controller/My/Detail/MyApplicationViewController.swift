//
//  MyApplicationViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/20.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class MyApplicationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var myTableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的申请"
        
        myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        myTableView?.delegate = self
        myTableView?.dataSource = self
        myTableView?.backgroundColor = BG_COLOR
        myTableView?.separatorStyle = .none
        self.view.addSubview(myTableView!)
        let cellNib = UINib(nibName: "MyApplicationTableViewCell", bundle: nil)
        myTableView?.register(cellNib, forCellReuseIdentifier: "cell")
        
    }
    
    //MARK: - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    //设置节尾高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    //设置每一节多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    //渲染cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyApplicationTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
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
