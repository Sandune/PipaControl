//
//  SystemSetViewController.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/18.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class SystemSetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var setTableView:UITableView!
    
    let name = ["清除缓存","帮助与反馈","关于我们"]
    
    let img = [#imageLiteral(resourceName: "清除缓存"),#imageLiteral(resourceName: "帮助与反馈"),#imageLiteral(resourceName: "关于我们")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        
        setTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        setTableView?.delegate = self
        setTableView?.dataSource = self
        setTableView?.backgroundColor = BG_COLOR
        setTableView?.tableFooterView = UIView.init(frame: CGRect.zero)
        setTableView?.autoresizesSubviews = false
        self.view.addSubview(setTableView!)
        
        setTableView?.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        }
        
        let cellNib = UINib(nibName: "MyTableViewCell", bundle: nil)
        
        setTableView?.register(cellNib, forCellReuseIdentifier: "cell")
        
    }
    
    //MARK: - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    //设置每一节多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    //渲染cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyTableViewCell
        
        cell.selectionStyle = .none
        
        cell.listIconImageView.image = img[indexPath.row]
        
        var size = ""
        
        if indexPath.row == 0 {
            size = "(" + ClearTheCache.cacheSize + ")"
        }
        
        cell.listNameLabel.text = name[indexPath.row] + size
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if !ClearTheCache.clearCache() {
                let indexPath = IndexPath.init(row: indexPath.row, section: 0)
                setTableView?.reloadRows(at: [indexPath], with: .automatic)
                createTopBarNotification(msg: "清除成功")
                topBarNotificationHide()
            }
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
