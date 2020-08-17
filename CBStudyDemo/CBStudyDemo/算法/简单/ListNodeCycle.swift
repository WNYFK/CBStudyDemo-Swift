//
//  ListNodeCycle.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/26.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct ListNodeCycle {

    func hasCycle1(head: ListNode?) -> Bool {
        guard let head = head, head.next != nil else { return false }
        var array: [ListNode] = [head]
        var p = head.next
        while let tmpP = p {
            if array.contains(where: { $0.val == tmpP.val }) {
                return true
            }
            array.append(tmpP)
            p = tmpP.next
        }
        
        return false
    }

    func cycleListNode1() {
        let head = ListNode.listNode([1, 2, 3, 4, 5])
        head?.tail?.next = head?.next
        let result = hasCycle1(head: head)
        print(result)
    }

    func hasCycle2(head: ListNode?) -> Bool {
        guard head != nil, head?.next != nil else { return false }
        var p1 = head
        var p2 = p1
        while p2?.next != nil {
            p1 = p1?.next
            p2 = p2?.next?.next
            if p1?.val == p2?.val { return true }
        }
        return false
    }

    func cycleListNode2() {
        let head = ListNode.listNode([1, 2, 3, 4, 5])
        head?.tail?.next = head?.next
        let result = hasCycle2(head: head)
        print(result)
    }

}
