//
//  CBHomeViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit
import SnapKit

struct CBTableCellItem: CBTableViewItemProtocol {
    var cellType: CBCellType.Type
    
    let title: String
    var action: CBEmptyClosure?
    
    init(title: String, cellType: CBCellType.Type = CBTableViewCell.self, action: CBEmptyClosure?) {
        self.title = title
        self.cellType = cellType
        self.action = action
    }
}

final class CBHomeViewController: CBTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationItem = CBTableCellItem(title: "动画", action: push(viewController: CBAnimationViewController.self))
        let racSwiftItem = CBTableCellItem(title: "RACSwift") {
            
        }
        sections = [CBSectionItem<String>(elements: [animationItem, racSwiftItem])]
    }
}

final class CBTableViewCell: CBCellType {
    private let titleLabel = UILabel(frame: .zero)
    var item: CBTableViewItemProtocol? {
        didSet {
            guard let item = item as? CBTableCellItem else { return }
            titleLabel.text = item.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
