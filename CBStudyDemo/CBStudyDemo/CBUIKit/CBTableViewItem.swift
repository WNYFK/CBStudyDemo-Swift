//
//  CBTableViewItem.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit

typealias CBCellType = UITableViewCell & CBTableViewCellProtocol
typealias CBEmptyClosure = (() -> Void)

protocol CBTableViewItemProtocol {
    var cellType: CBCellType.Type { get }
    var action: CBEmptyClosure? { get }
}

extension CBTableViewItemProtocol {
    var action: CBEmptyClosure? { return nil }
}

protocol CBTableViewCellProtocol: class {
    var item: CBTableViewItemProtocol? { get set }
}
