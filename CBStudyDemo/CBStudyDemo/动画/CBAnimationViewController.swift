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

// https://github.com/AlfredTheBest/iOS_core_animation
final class CBAnimationViewController: CBBaseViewController {
    private let colorLayer = CBLayer(frame: CGRect(x: 10, y: 200, width: 100, height: 100), bgColor: .red)
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
        setupPart9_2()
    }
}

// 基于定时器的动画
extension CBAnimationViewController {
    fileprivate func setupPart10_1() {
        
    }
}

// 缓存
extension CBAnimationViewController {
    fileprivate func setupPart9_2() {
        let layerView = CBView(frame: CGRect(x: 10, y: 200, width: 200, height: 200), bgColor: .green)
        view.addSubview(layerView)
        
        let function = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let point1 = UnsafeMutablePointer<Float>.allocate(capacity: 2)
        let point2 = UnsafeMutablePointer<Float>.allocate(capacity: 2)
        function.getControlPoint(at: 1, values:point1)
        function.getControlPoint(at: 2, values: point2)
        
        let controlPoint1: CGPoint = CGPoint(x: point1[0].cgFloat, y: point1[1].cgFloat)
        let controlPoint2: CGPoint = CGPoint(x: point2[0].cgFloat, y: point2[1].cgFloat)
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addCurve(to: CGPoint(x: 1, y: 1), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.apply(CGAffineTransform(scaleX: 200, y: 200))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        layerView.layer.addSublayer(shapeLayer)
        layerView.layer.isGeometryFlipped = true
    }
    
    fileprivate func setupPart9_1() {
        view.layer.addSublayer(colorLayer)
        changeBtn.reactive.controlEvents(.touchUpInside).observeValues { _ in
            let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
            animation.duration = 2
            animation.values = [UIColor.blue.cgColor, UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
            let fn1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            let fn2 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            let fn3 = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.timingFunctions = [fn1, fn2, fn3]
            self.colorLayer.add(animation, forKey: nil)
        }
    }
    
    fileprivate func setupPart9() {
        view.layer.addSublayer(colorLayer)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let position: CGPoint = touches.first?.location(in: view) ?? .zero
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(1.0)
//        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
//        colorLayer.position = position
//        CATransaction.commit()
//    }
}

// 图层时间
extension CBAnimationViewController {
    fileprivate func setupPart8() {
        changeBtn.reactive.controlEvents(.touchUpInside).observeValues { _ in
            self.colorLayer.timeOffset += 0.1
        }
        
        
        let containerView = CBView(frame: CGRect(x: 10, y: 150, width: 300, height: 300), bgColor: .green)
        view.addSubview(containerView)
        colorLayer.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        containerView.layer.addSublayer(colorLayer)
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        containerView.layer.sublayerTransform = perspective
        colorLayer.speed = 0
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.toValue = Double.pi / 2
        animation.duration = 1
        colorLayer.add(animation, forKey: nil)
        colorLayer.timeOffset = 0.5
    }
    
    @objc func panHandle(pan: UIPanGestureRecognizer) {
        var x: Double = Double(pan.translation(in: view).x)
        x /= 200.0
        var timeOffset = colorLayer.timeOffset
        timeOffset = min(0.999, max(0.0, timeOffset - x))
        colorLayer.timeOffset = timeOffset
        pan.setTranslation(.zero, in: view)
    }
}

extension CBAnimationViewController: CAAnimationDelegate {
    fileprivate func setupPart7_4() {   //过渡动画
        var index: Int = 0
        let imgs: [UIImage?] = [UIImage(named: "icon_back_to_top"), UIImage(named: "icon_cinema_noPermission"), UIImage(named: "icon_event_star_big"), UIImage(named: "icon_event_starHalf_big")]
        let imgView = UIImageView(frame: CGRect(x: changeBtn.cb.left, y: changeBtn.cb.bottom + 100, width: 100, height: 100))
        imgView.image = imgs[0]
        view.addSubview(imgView)

        changeBtn.reactive.controlEvents(.touchUpInside).observeValues { _ in
            let transition = CATransition()
            transition.type = kCATransitionFade
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.6
            imgView.layer.add(transition, forKey: "aaa")
            index = (index + 1) % imgs.count
            imgView.image = imgs[index]
        }
    }
    
    fileprivate func setupPart7_3() {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3
        view.layer.addSublayer(pathLayer)
        view.layer.addSublayer(colorLayer)
        
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        animation1.path = bezierPath.cgPath
        animation1.rotationMode = kCAAnimationRotateAuto
        
        let animation2 = CABasicAnimation(keyPath: "backgroundColor")
        animation2.toValue = UIColor.green.cgColor
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1, animation2]
        groupAnimation.duration = 2
        colorLayer.add(groupAnimation, forKey: nil)
    }
    
    fileprivate func setupPart7_2() {
        let shipLayer = CBLayer(frame: CGRect(x: 100, y: 200, width: 120, height: 120), bgColor: .clear)
        shipLayer.contents = UIImage(named: "icon_cinema_noPermission")?.cgImage
        view.layer.addSublayer(shipLayer)
        
        changeBtn.reactive.controlEvents(.touchUpInside).observeValues { _ in
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.duration = 2
            animation.byValue = CGFloat(Double.pi * 2)
            shipLayer.add(animation, forKey: nil)
        }
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: view) else { return }
//        if let _ = colorLayer.hitTest(point) {
//            colorLayer.backgroundColor = UIColor.random.cgColor
//        } else {
//            CATransaction.begin()
//            CATransaction.setAnimationDuration(4.0)
//            colorLayer.position = point
//            CATransaction.commit()
//        }
//    }
    
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
