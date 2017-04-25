//
//  SecondVC.swift
//  ScrollConflict_Swift
//
//  Created by Tech-zhangyangyang on 2017/4/25.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

import UIKit

class SecondVC: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !(self.navigationController?.viewControllers.contains(self))! {
            print("正在popping回上层....")
        }
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.navigationController?.viewControllers.count == 2 {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "左滑返回+scrollview+slider"
        self.view.backgroundColor = UIColor.white
         // 消除scrollview偏移64
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        let backImage = UIImage(named:"btn_back")
        
        let backButton = UIButton(type: .custom)
        backButton.setTitle("返回", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.setImage(backImage, for: .normal)
        backButton.backgroundColor = UIColor.green
        backButton.frame = CGRect(x:0,y:0,width:60,height:30)
        backButton.addTarget(self, action:#selector(clicked(_:)), for:.touchUpInside)
       
        let leftBarButtonItem = UIBarButtonItem(customView:backButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        let scrollView:CustomScrollView = CustomScrollView()
        scrollView.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:200)
        scrollView.backgroundColor = UIColor.gray
        scrollView.contentSize = CGSize(width:self.view.frame.size.width * 5,height:200)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        for i in 0..<5 {
            let label = UILabel()
            label.frame = CGRect(x:self.view.frame.size.width * CGFloat(i),y:0,width:self.view.frame.size.width, height:200)
            let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
            label.backgroundColor = colorRun
            label.text = "scrollview第\(i)页面"
            scrollView.addSubview(label)
        }
        
        // 添加一个slider 用于演示 左滑返回手势 和slider滑动手势 以及 scrollview自身的左右滑动手势
        let slider1 = UISlider()
        slider1.frame = CGRect(x:0,y:20,width:200,height:60)
        slider1.backgroundColor = UIColor.green
        slider1.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        scrollView.addSubview(slider1)
        self.view.addSubview(scrollView)
        
        // 添加一个slider 用于演示 左滑返回和slider 手势
        let slider = UISlider()
        slider.frame = CGRect(x:0,y:300,width:150,height:60)
        slider.backgroundColor = UIColor.green
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(slider)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UISlider {
            return false
        }else {
            return true
        }
    }
    
    func sliderValueChanged(_ slider:UISlider)  {
        print("正在操作视图slider")
    }
    func clicked(_ button:UIButton){
        print("正在popping回上层....")
        _ = navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll\(scrollView.contentOffset)")
    }
}
