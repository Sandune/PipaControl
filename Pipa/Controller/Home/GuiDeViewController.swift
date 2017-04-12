//
//  GuiDeViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/8.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit

//引导页

class GuiDeViewController: UIViewController,UIScrollViewDelegate {

    var scrollView = UIScrollView()
    
    var pageControl = UIPageControl()
    
    let images = ["WechatIMG7","WechatIMG6","WechatIMG8"]
    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置page
        
        pageControl.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT-40)
        
        //设置移动点的颜色
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        //设置背景点的颜色
        pageControl.pageIndicatorTintColor = UIColor.white
        
        //设置点的个数
        pageControl.numberOfPages = images.count
        
        //搭建方法使点与屏幕一同滚动
        pageControl.addTarget(self, action:#selector(scrollViewDidEndDecelerating), for: UIControlEvents.valueChanged)
        
        
        
        //获取屏幕尺寸
        scrollView.frame = self.view.bounds
        
        //内容尺寸
        scrollView.contentSize = CGSize(width: CGFloat(images.count)*scrollView.frame.width, height: 0)
        
        //滑动分页
        scrollView.isPagingEnabled = true
        
        //关闭滚动
        scrollView.bounces = false
        
        //去掉滚动条
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        
        for i in 0 ..< images.count
        {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            imageView.image = UIImage(named: images[i])
            var frame = imageView.frame
            frame.origin.x = CGFloat(i)*SCREEN_WIDTH
            imageView.frame = frame
            
            scrollView.addSubview(imageView)
            self.view.addSubview(pageControl)
            
            
        }
        
        
    }
    
    var tre = true
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
        pageControl.currentPage = index
        if index == images.count - 1 && tre
        {
            
            btn = Utilitys.createBtnString(frame: CGRect(x: CGFloat(index)*SCREEN_WIDTH, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 50), title: "进入Pipa", titleColor: .white, titleSize: 20, target: self, action: #selector(GuiDeViewController.buttonClick(_:)), touch: .touchUpInside)
            self.btn.backgroundColor = UIColor.orange
            self.btn.alpha = 0
            
            //动画效果
            UIView.animate(withDuration: 1.5, delay: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.btn.frame = CGRect(x: CGFloat(index)*SCREEN_WIDTH, y: SCREEN_HEIGHT-100, width: SCREEN_WIDTH, height: 50)
                self.btn.alpha = 1.0
                self.scrollView.addSubview(self.btn)
                }, completion: nil)
            
            tre = false
        }
    }
    
    func buttonClick(_ button:UIButton){
        // 跳转到第二个页面
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let second = sb.instantiateViewController(withIdentifier: "Pipa")
        self.present(second, animated: true, completion: nil)
        
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
