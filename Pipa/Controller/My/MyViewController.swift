//
//  MyViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/6.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,LoginViewControllerDelegate {

    var loginOrRe:UIButton?
    
    let listName = ["我的活动","发布活动","我的空间","我的申请","我的付款","我的资料","收藏的活动","收藏的空间","设置"]
    
    let listImage = ["my_release","release","space","我的申请","pay_fee","message","collection","collection","设置"]
    
    var myTableView:UITableView?
    
    var myHeaderView = MyTableHeaderView()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if myTableView != nil {
            let indexPath = IndexPath.init(row: 8, section: 0)
            myTableView?.reloadRows(at: [indexPath], with: .none)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        
        if UserDefaults.standard.bool(forKey: "isLogin") {
            createMyInfoTableView()
        }else{
            createLoginBtn()
        }
        
    }
    
    //创建登录按钮
    func createLoginBtn(){
        
        loginOrRe = Utilitys.createBtnString(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "登录/注册", titleColor: .white, titleSize: 16, target: self, action: #selector(openLogin), touch: .touchUpInside)
        loginOrRe?.backgroundColor = NAV_COLOR
        self.view.addSubview(loginOrRe!)
        loginOrRe?.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(140)
            make.height.equalTo(60)
        }
        
    }
    
    //创建列表
    func createMyInfoTableView(){
        myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        myTableView?.delegate = self
        myTableView?.dataSource = self
        myTableView?.backgroundColor = BG_COLOR
        myTableView?.tableFooterView = UIView.init(frame: CGRect.zero)
        myTableView?.autoresizesSubviews = false
        self.view.addSubview(myTableView!)
        
        myTableView?.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        }
        
        let cellNib = UINib(nibName: "MyTableViewCell", bundle: nil)
        
        myTableView?.register(cellNib, forCellReuseIdentifier: "cell")
        
        myHeaderView = Bundle.main.loadNibNamed("MyTableHeaderView", owner: self, options: nil)?.last as! MyTableHeaderView
        myHeaderView.userNameLabel.text = "点击登录"
        myTableView?.tableHeaderView = myHeaderView
    }
    
    func openLogin(){
        
        let loginVC = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        
        loginVC.hidesBottomBarWhenPushed = true
        
        loginVC.delegate = self
        
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    //MAKE - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //设置每一节多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 9
    }
    
    //渲染cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyTableViewCell
        
        cell.selectionStyle = .none
        
        cell.listIconImageView.image = UIImage(named:listImage[indexPath.row])
        
        cell.listNameLabel.text = listName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var releaseVC:UIViewController?
        switch indexPath.row {
        case 0:
            releaseVC = MyEventsViewController.init(nibName: "MyEventsViewController", bundle: nil)
            break
        case 1:
            releaseVC = EventsReleaseViewController.init(nibName: "EventsReleaseViewController", bundle: nil)
            break
        case 2:
            releaseVC = MySpaceViewController.init(nibName: "MySpaceViewController", bundle: nil)
            break
        case 3:
            releaseVC = MyApplicationViewController.init(nibName: "MyApplicationViewController", bundle: nil)
            break
        case 4:
            releaseVC = MyPayViewController.init(nibName: "MyPayViewController", bundle: nil)
            break
        case 5:
            releaseVC = MyInfoViewController.init(nibName: "MyInfoViewController", bundle: nil)
            break
        case 6:
            releaseVC = CollectionEventsViewController.init(nibName: "CollectionEventsViewController", bundle: nil)
            break
        case 7:
            releaseVC = CollectionSpaceViewController.init(nibName: "CollectionSpaceViewController", bundle: nil)
            break
        case 8:
            releaseVC = SystemSetViewController.init(nibName: "SystemSetViewController", bundle: nil)
            break
        default:
            break
        }
        if releaseVC == nil {
            return
        }
        releaseVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(releaseVC!, animated: true)
        
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        let offsetY = scrollView.contentOffset.y;
        
        if offsetY < 0 {
            
            let rect = CGRect(x: offsetY/2, y: offsetY, width: SCREEN_WIDTH-offsetY, height: 230-offsetY)
            
            myHeaderView.bgImageView.frame = rect
            myHeaderView.translucentView.frame = rect
        }
        
    }
    
    
    

    func reloadView() {
        
        if UserDefaults.standard.bool(forKey: "isLogin") {
            loginOrRe?.removeFromSuperview()
            createMyInfoTableView()
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
