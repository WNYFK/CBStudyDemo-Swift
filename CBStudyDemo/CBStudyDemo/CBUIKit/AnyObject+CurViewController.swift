//
//  AnyObject+CurViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit

extension NSObject: CBExtensionsProvider {}

extension CBExtensions where Base: NSObject {
    var curViewController: UIViewController? {
        return (UIApplication.shared.delegate as? AppDelegate)?.curViewController
    }
}
