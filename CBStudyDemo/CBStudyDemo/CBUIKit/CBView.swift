//
//  CBView.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit

public class CBView: UIView {
    init(frame: CGRect, bgColor: UIColor) {
        super.init(frame: frame)
        backgroundColor = bgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView: CBExtensionsProvider {}

extension CBExtensions where Base: UIView {
    var top: CGFloat {
        get { return base.frame.origin.y }
        set {
            base.frame = CGRect(x: base.cb.left, y: newValue, width: base.cb.width, height: base.cb.height)
        }
    }
    var left: CGFloat {
        get { return base.frame.origin.x }
        set {
            base.frame = CGRect(x: newValue, y: base.cb.top, width: base.cb.width, height: base.cb.height)
        }
    }
    var bottom: CGFloat {
        get { return base.cb.top + base.cb.height }
        set {
            base.cb.top = newValue - base.cb.height
        }
    }
    var right: CGFloat {
        get { return base.cb.left + base.cb.width }
        set {
            base.cb.left = right - base.cb.width
        }
    }
    var width: CGFloat {
        get { return base.frame.size.width }
        set {
            base.frame = CGRect(origin: base.frame.origin, size: CGSize(width: newValue, height: base.cb.height))
        }
    }
    var height: CGFloat {
        get { return base.frame.size.height }
        set {
            base.frame = CGRect(origin: base.frame.origin, size: CGSize(width: base.cb.width, height: newValue))
        }
    }
    
    func addSubviews(views: [UIView]) {
        views.forEach(base.addSubview)
    }
}
