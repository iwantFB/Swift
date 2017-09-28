//
//  LimitInput.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/25.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit
class LimitInputViewController: BaseViewController,UITextViewDelegate {

    
    let input = UITextView.init();
    override func viewDidLoad() {
        super.viewDidLoad()
    
        _initUI();
    }
    
    func _initUI() {
        
        self.title = "输入框自动换行";
        
        //滑动视图在系统会自动偏移64像素
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "nothing", style: .plain, target: self, action: #selector(rightbtnAction));
        
        input.frame = CGRect(x: 10, y: 74, width: Tool.Screen_width()-20, height: 20);
        input.isScrollEnabled = false;
        input.backgroundColor = UIColor.blue;
        input.scrollRangeToVisible(NSRange(location: 0,length: 0));
        input.font = UIFont.systemFont(ofSize: 18);
        input.delegate = self;
        input.textContainerInset = UIEdgeInsets.zero;
        self.view.addSubview(input);
    }
    
    func rightbtnAction() {
        print("right");
    }
    
    //delegate，这个方法也能做，只是响应没有下面那个快
    func textViewDidChange(_ textView: UITextView) {
        
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let wholetext = "\(textView.text!)\(text)";
        print("shouldChangeTextIn \(wholetext)");
        let height = wholetext.boundingRect(with: CGSize(width: Tool.Screen_width()-20, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: 1), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18.0)], context: nil).height;
        textView.height = height;
        
        return true;
    }
    
}
