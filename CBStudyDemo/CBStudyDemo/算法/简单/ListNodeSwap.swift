//
//  ListNodeSwap.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/26.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

func swapPairs(head: ListNode?) -> ListNode? {
    guard let tmpHead = head, head?.next != nil else { return head }
    var p1: ListNode? = tmpHead
    var p11 = p1?.next
    let newHead = p1?.next
    var pre: ListNode?
    while p11 != nil {
        let p2 = p11?.next
        p11?.next = p1
        p1?.next = p2
        if pre != nil {
            pre?.next = p11
        }
        pre = p1
        p1 = p2
        p11 = p1?.next
        
    }
    return newHead
}
