//
//  ViewController.swift
//  ColorAnimation
//
//  Created by Javier Loucim on 11/10/2017.
//  Copyright © 2017 Qeeptouch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundView:BackgroundGradientAnimatedView?
    let colors1 = [#colorLiteral(red: 0.3333333333, green: 0.9294117647, blue: 0.8980392157, alpha: 1),#colorLiteral(red: 0.07450980392, green: 0.8352941176, blue: 0.8, alpha: 1)]
    let colors2 = [#colorLiteral(red: 0.3764705882, green: 0.5529411765, blue: 1, alpha: 1),#colorLiteral(red: 0.2588235294, green: 0.462745098, blue: 0.9843137255, alpha: 1)]
    let colors3 = [#colorLiteral(red: 1, green: 0.5333333333, blue: 0.3647058824, alpha: 1),#colorLiteral(red: 1, green: 0.4235294118, blue: 0.2117647059, alpha: 1)]
    let colors4 = [#colorLiteral(red: 0.9882352941, green: 0.2705882353, blue: 0.6784313725, alpha: 1),#colorLiteral(red: 0.8784313725, green: 0.0431372549, blue: 0.5176470588, alpha: 1)]

    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView = BackgroundGradientAnimatedView(frame: self.view.bounds)
        backgroundView?.startPoint = .top
        backgroundView?.endPoint = .bottom
        backgroundView?.animationDuration = 0.24
        self.view.insertSubview(backgroundView!, at: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getColors() -> Array<UIColor> {
        switch currentIndex {
        case 0:
            return colors1
        case 1:
            return colors2
        case 2:
            return colors3
        case 3:
            return colors4
        default:
            return colors1
        }
    }

    @IBAction func action1(_ sender: Any) {
        
        let colors:Array<UIColor> = getColors()
        
        backgroundView!.animateChangeToGradientColors(gradientColor1: colors.last!, gradientColor2: colors.first!)
        if currentIndex == 3 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    @IBAction func action2(_ sender: Any) {
//        backgroundView!.animateChangeToGradientColors(gradientColor1: colors.last!, gradientColor2: colors.first!)
    }
}

