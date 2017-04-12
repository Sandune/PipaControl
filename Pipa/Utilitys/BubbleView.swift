//
//  BubbleView.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/23.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    var contentEdgeInsets:UIEdgeInsets!
    
    var bubbleImageView:UIImageView!
    
    var contentLabel:UILabel!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 15)
        
        
        
        bubbleImageView = UIImageView()
        bubbleImageView.frame = self.bounds
        
        self.insertSubview(bubbleImageView, at: 0)
        
        
        contentLabel = UILabel()
        
        contentLabel.addObserver(self, forKeyPath: "text", options:[.new,.old], context: nil)
        
        var rect = self.bounds
        rect.origin.x = self.contentEdgeInsets.left
        rect.origin.y = self.contentEdgeInsets.top
        rect.size.width = rect.size.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right
        rect.size.height = rect.size.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom
        
        contentLabel.frame = rect
        contentLabel.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        contentLabel.numberOfLines = 0
        self.addSubview(contentLabel)
        
    }

    //MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let text = change?[.newKey] as! NSString
        
        //通过文本信息计算尺寸大小
        let maxWidth = self.bounds.size.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right
        
        let maxSize = CGSize(width:maxWidth, height:CGFloat(MAXFLOAT))
        
        //计算尺寸的属性信息
//        let dic = [NSFontAttributeName : self.contentLabel.font]
        
        let rect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        
        //拿到label大小
        var labelRect = self.contentLabel.frame
        labelRect.size.width = rect.size.width
        labelRect.size.height = rect.size.height
        contentLabel.frame  = labelRect
        
        //设置泡泡图片
        var imageRect = bubbleImageView.frame;
        
        imageRect.size.height = rect.size.height + self.contentEdgeInsets.bottom + self.contentEdgeInsets.top;
        
        imageRect.size.width = rect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
        
        self.bubbleImageView.frame = imageRect;
        
        var selfRect = self.frame;
        selfRect.size.width = imageRect.size.width;
        selfRect.size.height = imageRect.size.height;
        
        self.frame = selfRect;
        
    }
    
    deinit{
        
        contentLabel.removeObserver(self, forKeyPath: "text")
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
