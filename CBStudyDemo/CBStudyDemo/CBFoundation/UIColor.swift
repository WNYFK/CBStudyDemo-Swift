//
//  UIColor.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/20.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        let red: CGFloat = CGFloat(arc4random()) / CGFloat(INT_MAX)
        let green: CGFloat = CGFloat(arc4random()) / CGFloat(INT_MAX)
        let blue: CGFloat = CGFloat(arc4random()) / CGFloat(INT_MAX)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
