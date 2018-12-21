//
//  CBAnimationViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import QuartzCore

final class CBAnimationViewController: CBBaseViewController {
    private let colorLayer = CBLayer(frame: CGRect(x: 100, y: 200, width: 100, height: 100), bgColor: .red)
    private lazy var changeBtn: UIButton = {
        let changeColorBtn = UIButton(type: .custom)
        changeColorBtn.setTitle("改变颜色", for: .normal)
        changeColorBtn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(changeColorBtn)
        changeColorBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
        return changeColorBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPart7_1()
    
        
    }
}

extension CBAnimationViewController: CAAnimationDelegate {
    fileprivate func setupPart7_2() {
        let shipLayer = CBLayer(frame: CGRect(x: 100, y: 200, width: 120, height: 120), bgColor: .clear)
    }
    
    fileprivate func setupPart7_1() {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3
        view.layer.addSublayer(pathLayer)
        
        let shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: 0, y: 150)
        shipLayer.contents = UIImage(named: "icon_cinema_noPermission")?.cgImage
        view.layer.addSublayer(shipLayer)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 4
        animation.path = bezierPath.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        shipLayer.add(animation, forKey: nil)
    }
    
    fileprivate func setupPart7() {
        view.layer.addSublayer(colorLayer)
        changeBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.toValue = UIColor.random.cgColor
            animation.delegate = self
            self?.colorLayer.add(animation, forKey: nil)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        colorLayer.backgroundColor = (anim as? CABasicAnimation)?.toValue as! CGColor
        CATransaction.commit()
    }
}

extension CBAnimationViewController {
    
    fileprivate func setupPart6_1() {
        colorLayer.position = CGPoint(x: view.cb.width / 2.0, y: view.cb.height / 2.0)
        view.layer.addSublayer(colorLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else { return }
        if let _ = colorLayer.hitTest(point) {
            colorLayer.backgroundColor = UIColor.random.cgColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(4.0)
            colorLayer.position = point
            CATransaction.commit()
        }
    }
    
    fileprivate func setupPart6() {
        let changeColorBtn = UIButton(type: .custom)
        changeColorBtn.setTitle("改变颜色", for: .normal)
        changeColorBtn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(changeColorBtn)
        changeColorBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
        
        let colorLayer = CBLayer(frame: CGRect(x: 200, y: 200, width: 100, height: 100), bgColor: .blue)
        let transition = CATransition.init()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        colorLayer.actions = ["backgroundColor": transition]
        view.layer.addSublayer(colorLayer)
        
        let lab = UILabel(frame: .zero)
        lab.textColor = .black
        lab.text = "test"
        
        changeColorBtn.reactive.controlEvents(.touchUpInside).observeValues { _ in
            colorLayer.backgroundColor = UIColor.random.cgColor
        }
    }
    fileprivate func part6() {
        
    }
}

extension CBAnimationViewController {
   fileprivate func part4() {
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
        
        let starImg = UIImage(named: "icon_event_star_big")
        let imgView = UIImageView(image: starImg)
        imgView.frame = CGRect(x: view.cb.width / 2, y: view.cb.height / 2, width: 25, height: 25)
        imgView.backgroundColor = .clear
        view.addSubview(imgView)
        
        
        let maskLayer = CBLayer(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)), bgColor: .clear)
        maskLayer.contents = UIImage(named: "icon_cinema_noPermission")?.cgImage
        imgView.layer.mask = maskLayer
    }
}
