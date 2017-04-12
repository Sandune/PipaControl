//
//  ClearTheCache.swift
//  Pipa
//
//  Created by 黄景川 on 17/1/13.
//  Copyright © 2017年 Pipa. All rights reserved.
//

import UIKit

class ClearTheCache: NSObject {
    
    
    //计算缓存大小
    static var cacheSize: String{
        get{
            let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let fileManager = FileManager.default
            
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExists(atPath: basePath!){
                    let childrenPath = fileManager.subpaths(atPath: basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.appending("/").appending(path)
                            do{
                                let attr = try fileManager.attributesOfItem(atPath: childPath)
                                let fileSize = attr[FileAttributeKey.size] as! Float
                                total += fileSize
                                
                            }catch _{
                                
                            }
                        }
                    }
                }
                
                return total
            }
            
            
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    class func clearCache() -> Bool {
        var result = true
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    result = false
                }
            }
        }
        
        return result
    }
   
}
