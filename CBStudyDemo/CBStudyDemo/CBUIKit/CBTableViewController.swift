//
//  CBTableViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import UIKit

class CBTableViewController: CBBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var sections: [CBSectionItem<String>] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].elements[indexPath.row]
        let identifier = NSStringFromClass(item.cellType)
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(item.cellType)) ?? item.cellType.init(style: .default, reuseIdentifier: identifier)
        (cell as? CBTableViewCellProtocol)?.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sections[indexPath.section].elements[indexPath.row]
        item.action?()
    }
}
