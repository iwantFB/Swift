//
//  GradientColor.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/9/28.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit
class GradientColor: BaseViewController {
    
    var colorSets = [[CGColor]]()
    var currentColorIndex:Int!
    let brightSkyColor_R = 21.0
    let brightSkyColor_G = 105.0
    let brightSkyColor_B = 203.0
    let darkSkyColor_R = 8.0
    let darkSkyColor_G = 33.0
    let darkSkyColor_B = 63.0
    
    let highestTemperatureColor_R = 255.0
    let highestTemperatureColor_G = 200.0
    let highestTemperatureColor_B = 101.0
    let lowestTemperatureColor_R = 47.0
    let lowestTemperatureColor_G = 169.0
    let lowestTemperatureColor_B = 199.0
    
    let lowestTemperature = 18
    let highestTemperature = 41
    
    var totalIndex = 0
    
    lazy var gradienLayer:CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint.init(x: 0, y: 0)
        gradient.endPoint = CGPoint.init(x: 1, y: 1)
        return gradient;
    }()//渐变layer
    let timeLb = UILabel();//左右2个label
    
    lazy var _temperatureLabel:UILabel = {//懒加载
        let label = UILabel();
        label.frame = CGRect.init(x: 10, y: 74, width: 80, height: 30);
        label.text = "18 ℃";
        label.textColor = UIColor.white;
        return label;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        _setupUI()
        //添加手势
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handlePangesture(sender:)));
        self.view.addGestureRecognizer(panGesture)
        
    }
    
    var lastY:CGFloat = 0.0, lastTotalIndex = 0, deltaOrigin = 0, indexForUp = 0
    func handlePangesture(sender:UIPanGestureRecognizer){
        let velocity = sender.velocity(in: self.view)
        let tranY = sender.translation(in: self.view).y
        if lastY == 0 || tranY * lastY < 0{
            lastY = tranY
            lastTotalIndex = totalIndex
        }
        let scopeY = self.view.frame.height / 24.0
        if velocity.y > 0 && totalIndex < 23{
            totalIndex = Int((tranY - lastY) /  scopeY)
            if totalIndex == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex += deltaOrigin
            lastTotalIndex = totalIndex
        }
        if velocity.y < 0 && totalIndex > 1{
            indexForUp = Int((tranY - lastY) / scopeY)
            if indexForUp == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex = deltaOrigin + indexForUp
            lastTotalIndex = totalIndex
        }
        changeColor()
        changeLabels()
    }
    
    func changeLabels() {
        guard lastTotalIndex > 0 && lastTotalIndex < 25 else {
            return
        }
        if lastTotalIndex < 12 {
            _temperatureLabel.text = "\(lowestTemperature + lastTotalIndex) ℃"
        }
        else {
            _temperatureLabel.text = "\(highestTemperature - lastTotalIndex) ℃"
        }
        timeLb.text = "\(lastTotalIndex):00"
    }
    
    
    func changeColor() {
        guard lastTotalIndex > 0 && lastTotalIndex < 24 else {//功能类似NSAssert，不过是取反
            return
        }
        if lastTotalIndex < 12 {
            gradienLayer.colors = colorSets[lastTotalIndex]
        }
        else {
            gradienLayer.colors = colorSets[23 - lastTotalIndex]
        }
    }
    
    //创建颜色集合
    func createColorSet(){
        for index in 1...12 {
            colorSets.append(colorSet(index: Double(index)))
        }
        
        currentColorIndex = 0;
    }
    
    func colorSet(index:Double) ->Array<CGColor>{
        let sky_r = darkSkyColor_R + (brightSkyColor_R - darkSkyColor_R) * (index - 1) / 11.0
        let sky_g = darkSkyColor_G + (brightSkyColor_G - darkSkyColor_G) * (index - 1) / 11.0
        let sky_b = darkSkyColor_B + (brightSkyColor_B - darkSkyColor_B) * (index - 1) / 11.0
        
        let tmpr_r = lowestTemperatureColor_R + (highestTemperatureColor_R - lowestTemperatureColor_R) * (index - 1) / 11.0
        let tmpr_g = lowestTemperatureColor_G + (highestTemperatureColor_G - lowestTemperatureColor_G) * (index - 1) / 11.0
        let tmpr_b = lowestTemperatureColor_B + (highestTemperatureColor_B - lowestTemperatureColor_B) * (index - 1) / 11.0
        
        return [UIColor(red: CGFloat(sky_r/255.0), green: CGFloat(sky_g/255.0), blue: CGFloat(sky_b/255.0), alpha: 1).cgColor,
                UIColor(red: CGFloat(tmpr_r/255.0), green: CGFloat(tmpr_g/255.0), blue: CGFloat(tmpr_b/255.0), alpha: 1).cgColor]
    }
    
    //初始化UI
    func _setupUI() {
        
        self.title = "渐变色"
        timeLb.frame = CGRect(x: 350, y: 74, width: 100, height: 100)
        timeLb.text = "1:00"
        timeLb.textColor = UIColor.white
        timeLb.font = UIFont.systemFont(ofSize: 28)
        self.view.addSubview(self.timeLb)
        self.view.addSubview(_temperatureLabel)
        
        createColorSet();
        gradienLayer.frame = self.view.bounds
        gradienLayer.colors = colorSets[currentColorIndex];
        self.view.layer.addSublayer(gradienLayer)
    }
}
