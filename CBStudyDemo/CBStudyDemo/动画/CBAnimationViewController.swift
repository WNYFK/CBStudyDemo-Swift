//
//  CBAnimationViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit

final class CBAnimationViewController: CBBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "icon_event_star_big")

        let layer1 = CBLayer(frame: CGRect(origin: CGPoint(x: 70, y: 80), size: CGSize(width: 30, height: 30)), bgColor: .red)
        layer1.contents = img?.cgImage
        layer1.contentsGravity = kCAGravityResizeAspect
        layer1.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        
        let layer2 = CBLayer(frame: CGRect(origin: CGPoint(x: layer1.cb.right, y: 80), size: CGSize(width: 30, height: 30)), bgColor: .red)
        layer2.contents = img?.cgImage
        layer2.contentsGravity = kCAGravityResizeAspect
        layer2.contentsRect = CGRect(x: 0.5, y: 0, width: 0.5, height: 0.5)
        
        let layer3 = CBLayer(frame: CGRect(origin: CGPoint(x: layer1.cb.left, y: layer1.cb.bottom), size: CGSize(width: 30, height: 30)), bgColor: .red)
        layer3.contents = img?.cgImage
        layer3.contentsGravity = kCAGravityResizeAspect
        layer3.contentsRect = CGRect(x: 0, y: 0.5, width: 0.5, height: 0.5)
        
        let layer4 = CBLayer(frame: CGRect(origin: CGPoint(x: layer2.cb.left, y: layer2.cb.bottom), size: CGSize(width: 30, height: 30)), bgColor: .red)
        layer4.contents = img?.cgImage
        layer4.contentsGravity = kCAGravityResizeAspect
        layer4.contentsRect = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5)
        
        let shadowLayer = CBLayer(frame: CGRect(x: layer4.cb.right, y: layer4.cb.bottom + 10, width: 100, height: 100), bgColor: .clear)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowOffset = CGSize(width: 3, height: 3)
        shadowLayer.cornerRadius = 20
        
        let lalyer5 = CBLayer(frame: CGRect(x: 0, y: 0, width: 100, height: 100), bgColor: .red)
        lalyer5.cornerRadius = 20
        lalyer5.masksToBounds = true
        shadowLayer.addSublayer(lalyer5)
        view.layer.cb.addSubLayers(layers: [layer1, layer2, layer3, layer4, shadowLayer])
        
        let layer51 = CBLayer(frame: CGRect(x: -20, y: -20, width: 60, height: 60), bgColor: .green)
        lalyer5.addSublayer(layer51)
        
        let circlePath = CGMutablePath()
        circlePath.addEllipse(in: shadowLayer.bounds)
        shadowLayer.shadowPath = circlePath
    }
}
