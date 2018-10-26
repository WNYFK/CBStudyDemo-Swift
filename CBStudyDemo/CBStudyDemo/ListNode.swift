//
//  ListNode.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/23.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    static func ListNoe(_ vals: [Int]) -> ListNode? {
        guard !vals.isEmpty else { return nil }
        let result = ListNode(0)
        var tmp: ListNode? = result
        vals.forEach { (val) in
            tmp?.next = ListNode(val)
            tmp = tmp?.next
        }
        return result.next
    }
}
