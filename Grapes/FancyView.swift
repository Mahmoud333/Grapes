//
//  FancyView.swift
//  Grapes
//
//  Created by Mahmoud Hamad on 5/15/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

class FancyView: UIView, DropShadow, CAAnimationDelegate {
    
    var gradient: CAGradientLayer?
    
    var fromColor = [UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1).cgColor, UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1).cgColor]
    var toColors = [UIColor.red.cgColor, UIColor.orange.cgColor]
    
    override func awakeFromNib() {
        addDropShadowSMGL()
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.bounds
        self.gradient?.colors = fromColor
        
        self.gradient?.locations = [0.0, 0.5, 1.0]
        self.gradient?.startPoint = CGPoint(x: 0.0, y: 0.0)
        self.gradient?.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        self.layer.insertSublayer(gradient!, at: 0)
        
        animateLayer()
    }
    
    func animateLayer(){
        self.gradient?.colors = toColors
        var animation: CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        animation.fromValue = fromColor
        animation.toValue = toColors
        animation.duration = 10.00
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCATransitionFromLeft
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self

        self.gradient?.add(animation, forKey: "animateGradient")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.toColors = self.fromColor
        self.fromColor = self.gradient?.colors as! [CGColor]
        animateLayer()
    }
    
}
