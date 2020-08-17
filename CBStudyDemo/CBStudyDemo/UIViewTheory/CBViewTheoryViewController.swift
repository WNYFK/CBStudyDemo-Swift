//
//  CBViewTheoryViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/12.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import UIKit

final class CBViewTheoryViewController: CBBaseViewController {
    var views: [CBView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("更新层级", for: .normal)
        changeBtn.setTitleColor(.black, for: .normal)
        
        let view1 = CBView(frame: .zero, bgColor: .black)
        let view2 = CBView(frame: .zero, bgColor: .red)
        let view3 = CBView(frame: .zero, bgColor: .yellow)
        let view4 = CBView(frame: .zero, bgColor: .green)
        view.cb.addSubviews(views: changeBtn, view1)
        
        changeBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            guard let v = self?.views.first else { return }
            view1.bringSubview(toFront: v)
            self?.views.append(v)
            self?.views.removeFirst()
        }
        
        changeBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(100)
            make.top.equalTo(20)
        }
        
        view1.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(changeBtn.snp.bottom).offset(20)
            make.height.equalTo(200)
        }
        
        views = [view2, view3, view4]
        view1.cb.addSubviews(views: views)
        view2.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        view3.snp.makeConstraints { (make) in
            make.left.equalTo(view2.snp.right).offset(10)
            make.right.equalTo(-20)
            make.height.equalTo(70)
        }
        view4.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(70)
            make.width.equalTo(40)
            make.height.equalTo(50)
        }
    }
}
