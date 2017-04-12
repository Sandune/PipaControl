//
//  CacheFunc.swift
//  Pipa
//
//  Created by 黄景川 on 17/2/9.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class CacheFunc: NSObject {
    
    /*
     获取沙盒路径
     */
    class func cachePath(proName:String) -> String{
        let cachePath = NSHomeDirectory() + "/Library/Caches/proData/" + proName + "/"
        let FM:FileManager = FileManager.default
        //判断当前路径是否存在
        if !FM.fileExists(atPath: cachePath){
            do {
                try FM.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            }catch _ as NSError{
//                print("存储路径错误")›
            }
        }
        return cachePath
    }
    
    //存储缓存
    class func saveDataToCache(proName:String,Data:NSData) -> (){
        
        let pathStr = self.cachePath(proName: proName) + "\(proName).plist"
        try? FileManager.default.removeItem(atPath: pathStr)
        Data.write(toFile: pathStr, atomically: true)
        
    }
    
    //取缓存
    class func getDataFromCache(proName:String) -> NSData? {
        
        let pathStr = self.cachePath(proName: proName) + "\(proName).plist"
        let data = NSData(contentsOfFile: pathStr)
        return data
        
    }
    
    
    
    
    
}
