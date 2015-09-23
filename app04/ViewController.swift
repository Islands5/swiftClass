//
//  ViewController.swift
//  app04
//
//  Created by 五島　僚太郎 on 2015/09/06.
//  Copyright (c) 2015年 fsail. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MyTableViewDelegate, MyTableViewDataSource {
    
    // Tableで使用する配列を設定する
    private let myItems: NSArray = ["TEST1", "TEST2", "TEST3"]
    var qiitaList: [[String:AnyObject]] = []
    private var myTableView: UITableView!
    private var mtv: MyTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qiitaList = Qiita.items() as! [[String : AnyObject]]
        // Do any additional setup after loading the view, typically from a nib.
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
//        // TableViewの生成する(status barの高さ分ずらして表示).
//        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
//        
//        // Cell名の登録をおこなう.
//        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//
//        // DataSourceの設定をする.
//        myTableView.dataSource = self
//        
//        // Delegateを設定する.
//        myTableView.delegate = self
//        
//        // Viewに追加する.
//        self.view.addSubview(myTableView)
        
        
        mtv = MyTableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight+100))
//        mtv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        mtv.mydataSource = self
        mtv.mydelegate = self
        mtv.reloadData()
        
        self.view.addSubview(mtv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    */
    func tableView(tableView: MyTableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let title: AnyObject? = qiitaList[indexPath.row]["title"]
        let url: AnyObject? = qiitaList[indexPath.row]["url"]
        let webViewController = UIViewController()
        let webView = UIWebView(frame: self.view.frame)
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url as! String!)!))
        webViewController.view.addSubview(webView)
        
        self.navigationController!.pushViewController(webViewController, animated: true)
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: MyTableView, numberOfRowsInSection section: Int) -> Int {
        return qiitaList.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: MyTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        // Cellに値を設定する.
        cell.textLabel!.text = qiitaList[indexPath.row]["title"] as? String
        
        return cell
    }

}

