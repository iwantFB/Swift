//
//  BaseViewController.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/18.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        baseUI();
    }
    
      func baseUI(){
        self.view.backgroundColor = UIColor.white;
        //避免系统给你的scrollerView滑动64px
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}
