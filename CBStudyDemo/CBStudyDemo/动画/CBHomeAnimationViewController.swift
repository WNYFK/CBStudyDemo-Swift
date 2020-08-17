//
//  CBHomeAnimationViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/26.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import Foundation

final class CBHomeAnimationViewController: CBTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "动画"
        let basePerportyItem = CBTableCellItem(title: "基本属性", action: push(viewController: CBAnimationBasePerportyViewController.self))
        sections = [CBSectionItem<String>(title: nil, elements: [basePerportyItem])]

    }
}
