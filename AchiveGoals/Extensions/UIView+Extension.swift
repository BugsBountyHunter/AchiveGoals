//
//  UIView+Extension.swift
//  AchiveGoals
//
//  Created by Ahmed SR on 7/21/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
extension UIView {
    func bindToKeyboard (){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name:Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    @objc func keyboardWillChanged(_ notification:NSNotification){
        let startingFram = (notification.userInfo! [UIKeyboardFrameBeginUserInfoKey] as? NSValue )?.cgRectValue
        print(startingFram?.origin.y as Any )
        let endingFram = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue )?.cgRectValue
        print(endingFram?.origin.y as Any)
        let deltaY = (endingFram?.origin.y)!  - (startingFram?.origin.y)!
        print(deltaY)
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        print(duration)
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        print(curve)
        // tracker Block movement
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            // originY = 0 and + deltay = 10 for example
            self.frame.origin.y += deltaY
        }, completion: nil)
        
    }
}
