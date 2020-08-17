//
//  CBAnimationBasePerportyViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2019/1/10.
//  Copyright © 2019 ChenBin. All rights reserved.
//

import UIKit

final class CBAnimationBasePerportyViewController: CBBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let view1 = CBView(frame: CGRect(x: 100, y: 200, width: 40, height: 50), bgColor: .red)
        let view2 = CBView(frame: CGRect(x: view1.cb.right + 30, y: view1.cb.top, width: view1.cb.width, height: view1.cb.height), bgColor: .green)
        let view3 = CBView(frame: CGRect(x: view2.cb.right + 30, y: view1.cb.top, width: view1.cb.width, height: view1.cb.height), bgColor: .yellow)

        view.cb.addSubviews(views: [view1, view2, view3])
        view1.layer.anchorPoint = CGPoint(x: 0.5, y: 0.8)
//        view2.layer.anchorPoint = .zero
//        view3.layer.anchorPoint = CGPoint(x: -0.5, y: -0.5)
        
        print(view1.layer.anchorPoint)
        print(view2.layer.anchorPoint)
        print(view3.layer.anchorPoint)
        print(view1.center)
        print(view2.center)
    }
}
