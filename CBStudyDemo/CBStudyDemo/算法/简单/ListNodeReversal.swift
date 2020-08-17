//
//  ListNodeReversal.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/25.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct ListNodeReversal {

    static func reverseList(head: ListNode?) -> ListNode? {
        guard let tmpHead = head, tmpHead.next != nil else { return head }
        let newHead = reverseList(head: tmpHead.next)
        tmpHead.next?.next = tmpHead
        tmpHead.next = nil
        return newHead
    }

    static func reverse() {
        let head = ListNode.listNode([1, 2, 3, 4, 5])
        let result = reverseList(head: head)
        head?.next = nil
        ListNode.printVal(node: result)
    }
    
}


