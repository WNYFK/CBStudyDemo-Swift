//
//  TreeNodeComAncestor.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/27.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct TreeNodeComAncestor {
    static func lowestComAncestor(head: TreeNode?, p: Int, q: Int) -> TreeNode? {
        guard head != nil else { return nil }
        if head?.val == p || head?.val == q { return head }
        let left = lowestComAncestor(head: head?.left, p: p, q: q)
        let right = lowestComAncestor(head: head?.right, p: p, q: q)
        if left == nil, right == nil { return nil }
        else if left != nil, right == nil { return left }
        else if left == nil, right != nil { return right }
        return head
    }
    
    static func test() {
        let lowTree = TreeNode(val: 3, left: TreeNode(val: 5, left: TreeNode(val: 6), right: TreeNode(val: 2, left: TreeNode(val: 7), right: TreeNode(val: 4))), right: TreeNode(val: 1, left: TreeNode(val: 0), right: TreeNode(val: 8)))

        let lowResult = lowestComAncestor(head: lowTree, p: 6, q: 4)
        
    }
}
