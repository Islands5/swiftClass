//
//  MyTableView.swift
//  app04
//
//  Created by 五島　僚太郎 on 2015/09/06.
//  Copyright (c) 2015年 fsail. All rights reserved.
//

import UIKit
import Foundation

@objc protocol MyTableViewDelegate:NSObjectProtocol, UIScrollViewDelegate {
    func tableView(tableView: MyTableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}

@objc protocol MyTableViewDataSource:NSObjectProtocol {
    func tableView(tableView: MyTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: MyTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

class MyTableView: UIScrollView, UIScrollViewDelegate {
    weak var mydataSource: MyTableViewDataSource?
    weak var mydelegate: MyTableViewDelegate?
    
    var cellHeight:CGFloat = 50
    var cellCnt:Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.delegate = self
//        for vTag in viewTag.allValues {
//            let y = CGFloat(Int(cellHeight) * (vTag.rawValue - 1) - 2)
//            let uv = UIView(frame: CGRectMake(10, y, 350, cellHeight))
//            uv.layer.borderColor = UIColor.grayColor().CGColor
//            uv.layer.borderWidth = 1
//            uv.tag = vTag.rawValue
//            let gesture = UITapGestureRecognizer(target: self, action: "returnIndex:")
//            uv.addGestureRecognizer(gesture)
//            super.addSubview(uv)
//        }
//        super.scrollEnabled = true
//        super.pagingEnabled = true
//        super.showsVerticalScrollIndicator = false
//        super.contentSize = CGSizeMake(0, cellHeight * CGFloat(13))
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        if (mydataSource?.respondsToSelector("tableView:numberOfRowsInSection:")) == true {
            cellCnt = mydataSource!.tableView(self, numberOfRowsInSection: 0)
        }
        self.contentSize = CGSizeMake(self.contentSize.width, CGFloat(cellCnt) * cellHeight)
        
        for (var i = 0; i < cellCnt; i++) {
            let cell = mydataSource!.tableView(self, cellForRowAtIndexPath: NSIndexPath(forRow: i, inSection: 0))
            cell.center = CGPointMake(self.frame.width / 2, CGFloat(i) * cellHeight + cellHeight / 2)
            cell.tag = i
            let gesture = UITapGestureRecognizer(target: self, action: "returnIndex:")
            cell.addGestureRecognizer(gesture)
            super.addSubview(cell)
        }
        
    }
    
    func returnIndex(sender: UITapGestureRecognizer){
      mydelegate!.tableView(self, didSelectRowAtIndexPath: NSIndexPath(forRow: sender.view!.tag, inSection: 0))
    }

}