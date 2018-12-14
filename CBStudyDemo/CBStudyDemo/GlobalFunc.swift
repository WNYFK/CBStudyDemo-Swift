//
//  GlobalFunc.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/18.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import UIKit

public func debugExample(_ desscription: String, _ action: () -> Void) {
    print("\n=========\(desscription)========\n")
    action()
}

func push(viewController: UIViewController.Type) -> CBEmptyClosure {
    return {
        let vc = viewController.init()
        vc.cb.curViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
