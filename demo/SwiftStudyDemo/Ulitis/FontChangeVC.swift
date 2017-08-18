//
//  FontChangeVC.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/16.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit

class FontChangeVC: UIViewController {
    

    let titleLb = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        _initUI();
    }
    
    //初始化
    func _initUI() {
        
        self.title = "改变字体";
        
        //创建一个label和一个按钮
        self.view.backgroundColor = UIColor.white;
        titleLb.frame = CGRect.init(x: 0, y: 74, width: Tool.Screen_width(), height: 49);
        titleLb.text = "I Am The King Of The World!!";
        titleLb.textAlignment = NSTextAlignment.center;
        self.view.addSubview(titleLb);
        
        //按钮
        let changeBtn = UIButton.init(type: UIButtonType.custom);
        changeBtn.frame = CGRect.init(x: 40, y: titleLb.bottom, width: Tool.Screen_width()-80, height: 60);
        changeBtn.setTitle("改变", for: UIControlState.normal);
        changeBtn.setTitleColor(UIColor.blue, for: UIControlState.normal);
        changeBtn.addTarget(self, action: #selector(btnAction), for: UIControlEvents.touchUpInside);
        self.view.addSubview(changeBtn);
    }
    
    func btnAction()  {
        let fontFamily = UIFont.familyNames;
        let total:Int = Int(arc4random());
        let index:Int = (total)%fontFamily.count;
        titleLb.font = UIFont.init(name: fontFamily[index], size: 14.0);
    }
}
