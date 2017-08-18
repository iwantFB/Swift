//
//  FrameTool.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/16.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit

extension UIView{

    //x
    var x:CGFloat{
        set{
        
        }
        get{
            return self.frame.origin.x;
        }
    }
    
    //y
    var y:CGFloat{
        set{
            self.frame = CGRect.init(x: x, y: newValue, width: width, height: height);
        }
        
        get{
            return self.bounds.size.height;
        }
    }
    
    //宽
    var width:CGFloat {
        set{
            self.width = newValue;
        }
        get{
            return self.bounds.width;
        }
    }
    
    //高
    var height:CGFloat{
        set{
            self.frame = CGRect.init(x: x, y: y, width: width, height: newValue);
        }
        
        get{
            return self.frame.height;
        }
    }
    
    //底部
    var bottom:CGFloat{
        set{
        self.frame = CGRect.init(x: x, y: y, width: width, height: y-newValue);
        }
        get{
            return self.frame.maxY;
        }
    }
    
}
