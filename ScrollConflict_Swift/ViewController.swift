//
//  ViewController.swift
//  ScrollConflict_Swift
//
//  Created by Tech-zhangyangyang on 2017/4/25.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "系统导航左滑返回Demo（防卡死版)"
        self.view.backgroundColor = UIColor.white
        let btn = UIButton(type: .custom)
        btn.setTitle("点击跳转下一页", for: .normal)
        btn.backgroundColor = UIColor.green
        btn.frame = CGRect(x:0,y:0,width:150,height:50)
        btn.center = self.view.center
        btn.addTarget(self, action:#selector(clicked(_:)), for:.touchUpInside)
        self.view.addSubview(btn)
    }

    func clicked(_ button:UIButton){
        let svc = SecondVC()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(svc, animated: true)
    }
}

