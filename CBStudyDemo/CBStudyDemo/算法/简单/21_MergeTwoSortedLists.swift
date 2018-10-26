//
//  21_MergeTwoSortedLists.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/17.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/merge-two-sorted-lists/description/

class MergeTwoSortedLists {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var p1 = l1
        var p2 = l2
        let result: ListNode = ListNode(0)
        var tmp: ListNode? = result
        while p1 != nil && p2 != nil {
            if p1!.val < p2!.val {
                tmp?.next = p1
                tmp = tmp?.next
                p1 = p1?.next
            } else {
                tmp?.next = p2
                tmp = tmp?.next
                p2 = p2?.next
            }
        }
        tmp?.next = p1 ?? p2
        return result.next
    }
}
