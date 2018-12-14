//
//  CBSectionItem.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import Foundation

struct CBSectionItem<T> {
    var title: T? = nil
    var elements: [CBTableViewItemProtocol] = []
    
    init(title: T? = nil, elements: [CBTableViewItemProtocol] = []) {
        self.title = title
        self.elements = elements
    }
    
    mutating func insertElement(_ element: CBTableViewItemProtocol) {
        self.elements.append(element)
    }
    
    mutating func insertElements(_ elements: [CBTableViewItemProtocol]) {
        self.elements += elements
    }
}
