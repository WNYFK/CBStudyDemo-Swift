//
//  GlobalFunc.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/18.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

public func debugExample(_ desscription: String, _ action: () -> Void) {
    print("\n=========\(desscription)========\n")
    action()
}
