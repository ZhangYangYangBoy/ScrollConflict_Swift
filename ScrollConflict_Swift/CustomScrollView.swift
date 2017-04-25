//
//  CustomScrollView.swift
//  ScrollConflict_Swift
//
//  Created by Tech-zhangyangyang on 2017/4/25.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

import UIKit

/*
 iOS响应者链
 •	The implementation of hitTest:withEvent: in UIResponder does the following:
	•	It calls pointInside:withEvent: of self
	•	If the return is NO, hitTest:withEvent: returns nil. the end of the story.
	•	If the return is YES, it sends hitTest:withEvent: messages to its subviews. it starts from the top-level subview, and continues to other views until a subview returns a non-nil object, or all subviews receive the message.
	•	If a subview returns a non-nil object in the first time, the first hitTest:withEvent: returns that object. the end of the story.
	•	If no subview returns a non-nil object, the first hitTest:withEvent: returns self
 */

class CustomScrollView: UIScrollView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView is UISlider {
            self.isScrollEnabled = false
        }else {
            self.isScrollEnabled = true
        }
        return hitView
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.panBack(gestureRecognizer: gestureRecognizer) {
            return false
        }
        return true
    }
    
    func panBack(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            let pan:UIPanGestureRecognizer! = UIPanGestureRecognizer()
            let point = pan.translation(in: self)
            let state:UIGestureRecognizerState = pan.state
            if state == UIGestureRecognizerState.began || state == UIGestureRecognizerState.possible {
                let location = gestureRecognizer.location(in: self)
                if point.x > 0 && location.x < 100 && self.contentOffset.x <= 0{
                    return true
                }
            }
        }
        return false
    }
}
