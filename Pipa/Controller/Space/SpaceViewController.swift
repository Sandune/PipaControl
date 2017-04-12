//
//  SpaceViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/6.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit
import PullToRefresh
import Alamofire

class SpaceViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ClickOnSelectViewDelegate {
    
    var spaceScrollView = UIScrollView()
    
    var selectBtnView = ClickOnSelectView()
    
    var mapView = UIView()
    
    var spaceTableView:UITableView?
    
    var pagenum = 0
    
    var pullRefresher = PullToRefresh()
    
    var upRefresher = PullToRefresh()
    
    var dataArr = Array<NSDictionary>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "空间"
        
        self.edgesForExtendedLayout = UIRectEdge(rawValue: UInt(0))
        self.automaticallyAdjustsScrollViewInsets = false
        self.modalPresentationCapturesStatusBarAppearance = false
        self.extendedLayoutIncludesOpaqueBars = false
        
        //设置按钮
        selectBtnView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH/2, height: 40)
        selectBtnView.center = CGPoint(x: SCREEN_WIDTH/2, y: 40)
        selectBtnView.delegate = self
        self.view.addSubview(selectBtnView)
        
        //创建内容元素
        createScrollerView()
        createMapView()
        createSpaceTableView()
        //将View置于最顶层
        self.view.bringSubview(toFront: selectBtnView)
        
    }
    
    //MARK: - CreateContent
    func createScrollerView() {
        
        //创建滚动视图
        spaceScrollView.frame = self.view.bounds
        spaceScrollView.contentSize = CGSize(width: SCREEN_WIDTH*2, height: 0)
        spaceScrollView.bounces = false
        spaceScrollView.alwaysBounceVertical = false
        spaceScrollView.isPagingEnabled = true
        spaceScrollView.showsVerticalScrollIndicator = false
        spaceScrollView.showsHorizontalScrollIndicator = false
        spaceScrollView.delegate = self
        self.view.addSubview(spaceScrollView)
        spaceScrollView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        }
        
    }
    
    func createMapView(){
        
        //地图界面
        mapView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        let mapImageView:UIImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        mapImageView.image = UIImage(named: "maps")
        mapView.addSubview(mapImageView)
        spaceScrollView.addSubview(mapView)
        
    }
    
    func createSpaceTableView(){
        
        //创建空间列表
        spaceTableView = UITableView.init(frame: CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT),style:UITableViewStyle.grouped)
        spaceTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        spaceTableView?.backgroundColor = BG_COLOR
        spaceTableView?.contentInset = UIEdgeInsetsMake(70, 0, 80, 0)
        spaceTableView?.delegate = self
        spaceTableView?.dataSource = self
        
        pullRefresher = PullToRefresh.init(height: 40, position: .top)
        upRefresher = PullToRefresh.init(height:49,position: .bottom)
        spaceTableView?.addPullToRefresh(pullRefresher, action: {
            
            self.dataArr.removeAll()
            self.pagenum = 0
            self.jsonRequest()
            
        })
        spaceTableView?.addPullToRefresh(upRefresher, action: {
            self.pagenum += 1
            self.jsonRequest()
        })
        
        //手动注册cell
        let cellNib = UINib(nibName: "SpaceTableViewCell", bundle: nil)
        spaceTableView?.register(cellNib, forCellReuseIdentifier: "cell")
        spaceScrollView.addSubview(spaceTableView!)
        

    }
    
    //MARK: - Request 网络请求
    func jsonRequest(){
        
        Alamofire.request(SEVER_IP + "/api/getSpaceList?pagesize=10&pagenum=\(pagenum)",
                          method: .get).responseJSON { (response) in
                            
                            if self.pagenum == 0{
                                
                                self.dataArr = response.result.value! as! Array
                                
                                if self.dataArr.count != 0 {
                                    
                                    self.spaceTableView?.reloadData()
                                    
                                    self.spaceTableView?.endRefreshing(at: .top)
                                    
                                }else{
                                    // 如果刷新失败
                                }
                            }else{
                                
                                
                                let arr = response.result.value! as! Array<NSDictionary>
                                
                                if arr.count != 0 {
                                    
                                    self.dataArr += arr
                                    
                                    self.spaceTableView?.reloadData()
                                    
                                }
                                
                                self.spaceTableView?.endRefreshing(at: .bottom)
                                
                            }
                            
        }
        
        
    }
    

    //MARK: - UITableViewDelegate
    //设置节数
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArr.count
    
    }
    
    //设置每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    //设置每一节多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    //渲染cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if dataArr.count == 0 {
            
            let cell = UITableViewCell()
            
            return cell
            
        }else{
            
            let identifier = "cell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SpaceTableViewCell
            
            let dic:NSDictionary = dataArr[indexPath.section]
            cell.contentView.frame = CGRect(x: 5, y: 0, width: SCREEN_WIDTH-10, height: cell.bounds.height)
            cell.contentView.clipsToBounds = true
            cell.contentView.layer.cornerRadius = 10
            cell.selectionStyle = .none
            cell.spaceNameLabel.text = dic["name"] as? String
            cell.spaceDetailLabel.text = dic["details"] as? String
            let url = URL(string:SEVER_IP + (dic["headimg"] as! String))
            cell.spaceImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "imgbad"), options: nil, progressBlock: nil, completionHandler: nil)
            
            return cell
        }
        
    }
    
    //点击cell回调
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showInTheSpaceDetail", sender: indexPath.section)
        
    }
    
    
    //MARK: - ClickOnSelectViewDelegate
    //滑动切换
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == spaceTableView {return}
        
        let offsetX = scrollView.contentOffset.x/SCREEN_WIDTH
        let btn = UIButton()
        btn.tag = Int(offsetX)
        if (dataArr.count == 0) {
            jsonRequest()
        }
        
        selectBtnView.selectWithView(sender: btn)
    }

    //点击按钮来切换
    func clickOnSelectView(sender:UIButton){
        
        let pageNumber = sender.tag
        
        UIView.animate(withDuration: 0.5) {
            
            self.spaceScrollView.contentOffset = CGPoint(x: CGFloat(pageNumber)*SCREEN_WIDTH, y: 0)
            
        }
    }
    
    deinit {
        spaceTableView?.removePullToRefresh(pullRefresher)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "showInTheSpaceDetail" {
            
            let detailPage = segue.destination as! SDetailViewController
            
            detailPage.detailDic = dataArr[sender! as! Int]
            
        }
        
    }
    

}
