//
//  Qiita.swift
//  app04
//
//  Created by 五島　僚太郎 on 2015/09/24.
//  Copyright © 2015年 fsail. All rights reserved.
//

import Foundation

class Qiita : NSObject {
    class func items() -> AnyObject {
        var qiitaList:[[String:AnyObject]] = []
        var url = "https://qiita.com/api/v2/items"
        var mRequestTask: NSURLSessionDataTask!
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        mRequestTask = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler: { data, response, error in
            var jsonObject:AnyObject?
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            if(statusCode == 200){
                if (error == nil) {
                    jsonObject = try! NSJSONSerialization.JSONObjectWithData(
                        data!,
                        options: NSJSONReadingOptions.AllowFragments) as AnyObject?
                    
                    if let qiitaJsonObject: AnyObject = jsonObject{
                        for origin in qiitaJsonObject as! [[String:AnyObject]]{
                            var dic: [String:AnyObject] = [:]
                            dic["title"] = origin["title"]
                            dic["url"] = origin["url"]
                            qiitaList.append(dic)
                        }
                    }
                }
                
            }
        })
        mRequestTask.resume()
        sleep(2)
        return qiitaList
    }
}