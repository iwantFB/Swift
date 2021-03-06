//
//  ViewController.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/16.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let dataArr:NSArray = ["改变字体","时钟","地理位置以及编码","输入自动换行","渐变色"];
    let vcArr:NSArray = [FontChangeVC(),TimerViewController(),PositionViewController(),LimitInputViewController(),GradientColor()];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initUI();
        
    }

    //初始化视图
    func _initUI() {
        
        self.title = "功能";
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Tool.Screen_width(), height: Tool.Screen_height()-64), style: UITableViewStyle.plain);
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView);
    }
    
    //delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell");
        }
        cell?.textLabel!.text = dataArr[indexPath.row] as? String;
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC:UIViewController = vcArr[indexPath.row] as! UIViewController;
        self.navigationController?.pushViewController(VC, animated: true);
        
    }
    
}

