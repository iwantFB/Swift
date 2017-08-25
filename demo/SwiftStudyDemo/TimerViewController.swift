//
//  TimerViewController.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/18.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    
    var timer = Timer();
    var timeLb:UILabel!;
    var time:Double = 0.0;
        
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupUI();
        
    }
    
    func setupUI() {
        
        self.title = "计时器";
        //创建标签和2个按钮
        self.view.backgroundColor = UIColor.white;
        timeLb = UILabel();
        timeLb.frame = CGRect.init(x: 0, y: 74, width: Tool.Screen_width(), height: 60);
        timeLb.textAlignment = NSTextAlignment.center;
        timeLb.font = UIFont.systemFont(ofSize: 20);
        timeLb.text = "0.0";
        self.view.addSubview(timeLb);
        
        //按钮 
        let startBtn = UIButton.init(type: UIButtonType.custom);
        let stopBtn = UIButton.init(type: UIButtonType.custom);
        startBtn.frame = CGRect.init(x: 0, y: Tool.Screen_height()-100, width: Tool.Screen_width()/2.0, height: 100);
        stopBtn.frame = CGRect.init(x: startBtn.frame.maxX, y: startBtn.y, width: startBtn.width, height: 100);
        startBtn .setTitle("开始", for: UIControlState.normal);
        stopBtn .setTitle("暂停", for: UIControlState.normal);
        stopBtn .setTitle("重启", for: UIControlState.selected);
        startBtn.addTarget(self, action: #selector(startCount), for: UIControlEvents.touchUpInside);
        stopBtn.addTarget(self, action: #selector(stopCount), for: UIControlEvents.touchUpInside);
        startBtn.setTitleColor(UIColor.blue, for: UIControlState.normal);
        stopBtn.setTitleColor(UIColor.blue, for: UIControlState.normal);
        self.view.addSubview(startBtn)
        self.view.addSubview(stopBtn)
    }
    
    //开始计时
    func startCount (){
        
        if timer.isValid {//在计时中，不做处理
            return;
        }else{//否则清除计时器，重新开始计时
            timer.invalidate();
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
                self.time+=0.1;
                self.timeLb.text = String.init(format: "%.1f", self.time);
            })
        }
    }
    
    //停止计时
    func stopCount (sender:UIButton){
        
        if time==0.0 {return;}//避免
        sender.isSelected = !sender.isSelected;
        if timer.isValid {
            timer.invalidate();
        }else{
            time = 0.0;
            timeLb.text = "0.0";
        }
    }
}
