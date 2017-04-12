//
//  EventsViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/12.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

import PullToRefresh

class EventsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var eventsTableView = UITableView()
    
    var pullToRefresh = PullToRefresh()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "活动"
        
        eventsTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        eventsTableView.backgroundColor = BG_COLOR
        
        eventsTableView.delegate = self
        
        eventsTableView.dataSource = self
        
        self.view.addSubview(eventsTableView)
        
        eventsTableView.separatorStyle = .none
        
        let cellNib = UINib(nibName: "EventsTableViewCell", bundle: nil)
        
        eventsTableView.register(cellNib, forCellReuseIdentifier: "cell")
        
        pullToRefresh = PullToRefresh.init(height: 64, position: .top)
        
        eventsTableView.addPullToRefresh(pullToRefresh) { 
            
        }

        
    }

    //MAKE - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    //设置每一节多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 8
    }
    
    //渲染cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EventsTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }

    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showEventsDetail", sender: nil)
    }
    
    override func updateViewConstraints() {
        eventsTableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
        
        super.updateViewConstraints()
    }
    
    deinit {
        eventsTableView.removePullToRefresh(pullToRefresh)
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
