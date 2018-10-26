//
//  2_AddTwoNumbers.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/19.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

class AddTwoNumbers {
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil && l2 == nil {
            return nil
        }
        var l1 = l1
        var l2 = l2
        let result: ListNode? = l1 ?? l2
        var tmp: ListNode? = result
        var carry: Int = 0
        while l1 != nil, l2 != nil {
            tmp!.val = l1!.val + l2!.val + carry
            carry = l1!.val / 10
            tmp!.val %= 10
            if tmp?.next != nil {
                tmp = tmp?.next
            }
            l1 = l1?.next
            l2 = l2?.next
        }
        if l1 != nil {
            while l1 != nil && carry != 0 {
                tmp!.val = carry + l1!.val
                carry = tmp!.val / 10
                tmp!.val %= 10
                l1 = l1?.next
                if l1 != nil {
                    tmp = tmp?.next
                }
            }
        } else if l2 != nil {
            tmp?.next = l2
            tmp = tmp?.next
            while l2 != nil && carry != 0 {
                tmp!.val = carry + l2!.val
                carry = tmp!.val / 10
                tmp!.val %= 10
                l2 = l2?.next
                if l2 != nil {
                    tmp?.next = l2
                    tmp = tmp?.next
                }
            }
        }
        if carry != 0 {
            tmp?.next = ListNode(carry)
        }
        return result
    }
}
