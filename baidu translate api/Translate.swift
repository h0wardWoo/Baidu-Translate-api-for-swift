//
//  translate.swift
//  ObjectRecognizer
//
//  Created by wuhaozheng on 2018/9/27.
//  Copyright © 2018 vmengblog. All rights reserved.
//

import UIKit
import AFNetworking
import Foundation



public var fanyiString: String = ""


class Translate {
    
    func startTranslate(rawString: String) {
        
        let manager = AFHTTPSessionManager()
        let url: String = "http://api.fanyi.baidu.com/api/trans/vip/translate"
        let q = rawString
        let from = "en"
        let to = "zh"
        let appid = "20180927000212995"
        let salt = String(Int.random())
        let miyao = "******"
        let string1: String = appid + q + salt + miyao
        let up_sign = MD5(string1)
        let sign=up_sign.lowercased()
        print(sign)
        let parameters: Dictionary = ["q":q, "from": from, "to": to, "appid" :appid, "salt": salt, "sign": sign]
        manager.post(url, parameters: parameters, success: { (operation,responseObject) -> Void in
            if responseObject != nil{
                let aa = (responseObject! as! NSDictionary)["trans_result"]
                let aString = (aa as! NSArray)[0]
                let yiString = (aString as! NSDictionary)["dst"] as! String
                fanyiString = yiString
            }           
        }) { (operation,error) -> Void in
            
            print(error)
        }
        
    }
}



func refreshTranslate() -> String {
    return(fanyiString)
    
}

extension Int {
    static func random() -> Int {
        return Int(arc4random())
    }
    
    static func random(range: Range<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
    }
}
