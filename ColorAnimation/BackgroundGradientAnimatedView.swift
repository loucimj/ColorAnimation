//
//  UIView+BackgroundAnimation.swift
//  ColorAnimation
//
//  Created by Javier Loucim on 12/10/2017.
//  Copyright © 2017 Qeeptouch. All rights reserved.
//

import Foundation
import UIKit

@objc
public enum GradientSourcePoint: Int {
    case left
    case top
    case right
    case bottom
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    var point: CGPoint {
        switch self {
        case .left: return CGPoint(x: 0.0, y: 0.5)
        case .top: return CGPoint(x: 0.5, y: 0.0)
        case .right: return CGPoint(x: 1.0, y: 0.5)
        case .bottom: return CGPoint(x: 0.5, y: 1.0)
        case .topLeft: return CGPoint(x: 0.0, y: 0.0)
        case .topRight: return CGPoint(x: 1.0, y: 0.0)
        case .bottomLeft: return CGPoint(x: 0.0, y: 1.0)
        case .bottomRight: return CGPoint(x: 1.0, y: 1.0)
        }
    }
}


class BackgroundGradientAnimatedView: UIView {
    private struct Animation {
        static let keyPath = "colors"
        static let key = "ColorChange"
    }

    var animationDuration: TimeInterval = 0.87
    var currentGradientColors:Array<UIColor> = [UIColor.lightGray, UIColor.darkGray]
    var startPoint:GradientSourcePoint = .topRight
    var endPoint:GradientSourcePoint = .bottomLeft

    private var gradient = CAGradientLayer()
    
    private var isInitialized = false
    
    private var shouldMoveToAnotherColor = true
    private var currentColor:UIColor = UIColor()
    private var secondColor:UIColor = UIColor()
    
    
    override func layoutSubviews() {
        gradient.frame = self.bounds
    }
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
    }

    private func setupView() {
        isInitialized = true
        gradient.frame = bounds
        gradient.colors = currentGradientColors
        gradient.startPoint = startPoint.point
        gradient.endPoint = endPoint.point
        gradient.drawsAsynchronously = true
        
        currentColor = self.backgroundColor ?? UIColor.white
        
        layer.insertSublayer(gradient, at: 0)

    }
    func animateChangeToGradientColors(gradientColor1:UIColor, gradientColor2:UIColor) {
        gradient.removeAllAnimations()
        if !isInitialized {
            setupView()
        }
        shouldMoveToAnotherColor = true
        secondColor = gradientColor2
        animateGradientTo(color: gradientColor1)
    }
    
    private func animateGradientTo(color: UIColor) {
        print("animate from \(currentColor) to \(color)")
        let animation = CABasicAnimation(keyPath: Animation.keyPath)
        animation.duration = animationDuration
        animation.toValue = [color.cgColor, currentColor.cgColor]
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradient.add(animation, forKey: Animation.key)
        currentGradientColors = [color, currentColor]
        currentColor = color
    }
    
}
extension BackgroundGradientAnimatedView: CAAnimationDelegate {
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = [currentGradientColors.first!.cgColor, currentGradientColors.last!.cgColor]
            if shouldMoveToAnotherColor {
                shouldMoveToAnotherColor = false
                animateGradientTo(color: secondColor)
            }
        }
    }
}



