//
//  Tool.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/16.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import Foundation
import UIKit;

class Tool: NSObject {
    
    //屏幕宽度
    static func Screen_width()->CGFloat{
        print("cool");
        return UIScreen.main.bounds.width;
    }
    
    //屏幕高度
    static func Screen_height()->CGFloat{
        return UIScreen.main.bounds.height;
    }
}
