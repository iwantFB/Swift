//
//  PositionViewController.swift
//  SwiftStudyDemo
//
//  Created by 胡斐 on 2017/8/18.
//  Copyright © 2017年 胡斐. All rights reserved.
//

import UIKit
import MapKit
class PositionViewController: BaseViewController,CLLocationManagerDelegate {

    let positonLb = FHKit.label();
    let geoCodeLb = FHKit.label();
    //定位对象要做为该类的一个属性，不然无法定位
    let locationManager = CLLocationManager();
    let geocoder = CLGeocoder();
    
    
    
    override func viewDidLoad() {
         super.viewDidLoad();
        
        setupUI();
    }
    
    func setupUI() {
    
        self.title = "地理位置以及编码";
    //添加背景
        let bgImgView = UIImageView();
        bgImgView.frame = CGRect.init(x: 0, y: 0, width: Tool.Screen_width(), height: Tool.Screen_height())
        bgImgView.image = #imageLiteral(resourceName: "phoneBg");
        //自动布局
         bgImgView.autoresizingMask = bgImgView.autoresizingMask.union(UIViewAutoresizing.flexibleLeftMargin).union(UIViewAutoresizing.flexibleTopMargin).union(UIViewAutoresizing.flexibleBottomMargin).union(UIViewAutoresizing.flexibleRightMargin);
       self.view.addSubview(bgImgView);
        
        //创建显示的经纬度的label
        positonLb?.frame = CGRect.init(x: 0, y: 64, width: Tool.Screen_width(), height: 30);
        positonLb?.numberOfLines = 0;
        positonLb?.text = "test";
        self.view.addSubview(positonLb!);
        
        //创建显示反编码的label
        geoCodeLb?.frame = CGRect.init(x: 0, y: (positonLb?.bottom)!+20, width: Tool.Screen_width(), height: 30);
        geoCodeLb?.text = "test";
        self.view.addSubview(geoCodeLb!);
        
        //点击按钮获取地理位置
        let geoBtn = FHKit.buttonWithFrame(frame: CGRect.init(x: 40, y: Tool.Screen_height()-100, width: Tool.Screen_width()-80, height: 40), title: "获取位置", target: self, action: #selector(geoBtnAction));
        geoBtn.setTitleColor(UIColor.white, for: UIControlState.normal);
        self.view.addSubview(geoBtn);
    }
    
    func geoBtnAction()  {
        //查看用户权限,switch的匹配不再局限于integer类型，更加强大，可以去看看，并且不用显式的加上break然后枚举的匹配枚举值需要加上.
        //获取定位
        
        locationManager.delegate = self;
        let authStatus:CLAuthorizationStatus = CLLocationManager.authorizationStatus();
        switch authStatus {
        case .notDetermined:
            print("没有授权");
            locationManager.requestAlwaysAuthorization()
        case .denied:
            print("被拒绝了");
        case .authorizedAlways:
            print("总是授权");
        case .authorizedWhenInUse:
            print("使用时授权");
        default:
            print("其他情况");
        }
        
       locationManager.startUpdatingLocation();
   
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last;
        
        positonLb?.text = String("经度:\(String(describing: location!.coordinate.latitude)) 纬度:\(String(describing: location!.coordinate.longitude))");
        reverseGeocode(location: location!);
        manager.stopUpdatingLocation();//停止定位
    }
    
    //将经纬度转换成地址
    func reverseGeocode(location:CLLocation){
        //geocoder必须是个属性哦
    geocoder.reverseGeocodeLocation(location) { (places, error) in
        
        print("hahhha \(location.coordinate.longitude)");
        if(error == nil) {
            let tempArray = places! as NSArray
            let mark = tempArray.firstObject as! CLPlacemark
            //                now begins the reverse geocode
            let addressDictionary = mark.addressDictionary! as NSDictionary
            let country = addressDictionary.value(forKey: "Country") as! String
            let city = addressDictionary.object(forKey: "City") as! String
            let street = addressDictionary.object(forKey: "Street") as? String
            let finalAddress = "\(String(describing: street)),\(city),\(country)"
            self.geoCodeLb?.text = finalAddress
            
        }
        }
    }
}
