//
//  MySpaceViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/20.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit
import PullToRefresh

class MySpaceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var spaceTableView:UITableView?
    
    var pullRefresher = PullToRefresh()
    
    var upRefresher = PullToRefresh()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的空间"
        
        //self.edgesForExtendedLayout = UIRectEdge(rawValue: UInt(0))
        
        //self.automaticallyAdjustsScrollViewInsets = false
        
        //self.modalPresentationCapturesStatusBarAppearance = false
        
        //self.extendedLayoutIncludesOpaqueBars = false
        
        createSpaceTableView()
        
    }
    
    
    func createSpaceTableView(){
        //创建空间列表
        spaceTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT),style:UITableViewStyle.grouped)
        
        spaceTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        
        spaceTableView?.backgroundColor = BG_COLOR
        
        spaceTableView?.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        
        spaceTableView?.delegate = self
        
        spaceTableView?.dataSource = self
        
        pullRefresher = PullToRefresh.init(height: 64, position: .top)
        
        upRefresher = PullToRefresh.init(height: 64, position: .bottom)
        
        spaceTableView?.addPullToRefresh(pullRefresher, action: {
            
        })
        
        spaceTableView?.addPullToRefresh(upRefresher, action: {
            
        })
        
        //手动注册cell
        let cellNib = UINib(nibName: "SpaceTableViewCell", bundle: nil)
        
        spaceTableView?.register(cellNib, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(spaceTableView!)
        
        spaceTableView?.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        })
        
    }
    
    //MARK: - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.contentView.frame = CGRect(x: 5, y: 0, width: SCREEN_WIDTH-10, height: cell.bounds.height)
        
        cell.contentView.clipsToBounds = true
        
        cell.contentView.layer.cornerRadius = 10
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    //点击cell回调
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = SDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    deinit {
        spaceTableView?.removePullToRefresh(pullRefresher)
        spaceTableView?.removePullToRefresh(upRefresher)
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
