//
//  ViewController.swift
//  MakeDampingWave
//
//  Created by Kun on 16/9/26.
//  Copyright © 2016年 Kun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dampingLayer: CAShapeLayer = CAShapeLayer.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        dampingLayer.frame = CGRect(x: 0, y: 100, width: CGRectGetWidth(self.view.frame), height: 200)
        dampingLayer.strokeColor = UIColor.lightGrayColor().CGColor
        dampingLayer.fillColor = UIColor.clearColor().CGColor
        dampingLayer.backgroundColor = UIColor.cyanColor().CGColor
        self.view.layer.addSublayer(dampingLayer)
        
        makeDamping(dampingLayer.frame.size, damping: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    func makeDamping(size : CGSize , damping: Double) {
        let dampingPath = UIBezierPath.init()
        
        dampingPath.moveToPoint(CGPoint(x:0, y:size.height / 2))
        let h = Double( size.height / 2 )
        for var x = 0.0, p = 5; p < Int(size.width); x += 0.01 , p += 5 {
            
            //pow(e, damping* (-x))  这里damping相当于阻尼系数，数值越大衰减越快， cos(x*60)  60 这个表示震动周期，越大震动次数越多
            let d = pow(M_E, Double(-x) * damping ) * cos(Double(x) * 60)
            let b = (2 * d - 1) * h
            let y = Double(size.height / 2) * (1 - d)	//这里用 1 减去 d 相当于给 h - h *d 相当于向下平移了 h, 用2减相当于平移了 2h,没搞懂
            dampingPath.addLineToPoint(CGPoint(x: CGFloat(p), y:CGFloat(y) ))
 
        }
        
        dampingLayer.path = dampingPath.CGPath;
        
    }

}

