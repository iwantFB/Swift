//
//  FHKit.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/18.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit

class FHKit: NSObject {
    
    
    /// 创建label
    ///
    static func label() -> UILabel!{
    
        let label = UILabel();
        label.textAlignment = NSTextAlignment.center;
        label.textColor = UIColor.white;
        return label;
    }
    
    static func buttonWithFrame(frame:CGRect,title:NSString?,target:AnyObject,action:Selector) -> UIButton {
    
        let btn = UIButton.init(type: UIButtonType.custom);
        btn.frame = frame;
        btn .setTitle(title! as String, for: UIControlState.normal);
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal);
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside);
        return btn;
    }
}
