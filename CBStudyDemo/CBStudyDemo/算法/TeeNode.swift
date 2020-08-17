//
//  TeeNode.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/27.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

func == (lhs: TreeNode?, rhs: TreeNode?) -> Bool {
    return lhs?.val == rhs?.val
}

func >= (lhs: TreeNode?, rhs: TreeNode?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else { return true }
    return lhs.val >= rhs.val
}

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}
