//
//  WeatherCollectionViewCell.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/20.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!//天气图
    @IBOutlet weak var tempLabel: UILabel!//当前温度
    @IBOutlet weak var lowTempLabel: UILabel!//最低温度
    @IBOutlet weak var highTempLabel: UILabel!//最高温度
    @IBOutlet weak var weatherLabel: UILabel!//天气名
    @IBOutlet weak var windDirectionLabel: UILabel!//风向
    @IBOutlet weak var humiLabel: UILabel!//湿度
    @IBOutlet weak var windLabel: UILabel!//风级
    @IBOutlet weak var pmLabel: UILabel!//PM2.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //定义渐变的颜色，多色渐变太魔性了，我们就用两种颜色
        let leftColor = UIColor.init(red: 42/255, green: 12/255, blue: 2/255, alpha: 1)
        let rightColor = UIColor.init(red: 2/255, green: 13/255, blue: 29/255, alpha: 1)
        
        //将颜色和颜色的位置定义在数组内
        let gradientColors: [CGColor] = [leftColor.cgColor, rightColor.cgColor]
        let gradientStart = CGPoint(x:0.0, y:0.5)
        let gradientEnd = CGPoint(x:1.0, y:0.5)
        
        //创建CAGradientLayer实例并设置参数
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = gradientStart
        gradientLayer.endPoint = gradientEnd
        
        //设置其frame以及插入view的layer
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }


}
