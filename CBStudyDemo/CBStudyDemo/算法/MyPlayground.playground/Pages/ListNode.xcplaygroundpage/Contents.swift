import UIKit

public class ListNode {
    public var val: Int
    public var next: ListNode?
    
    var tail: ListNode? {
        return ListNode.tail(self)
    }
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    static func listNode(_ vals: [Int]) -> ListNode? {
        guard !vals.isEmpty else { return nil }
        let result = ListNode(0)
        var tmp: ListNode? = result
        vals.forEach { (val) in
            tmp?.next = ListNode(val)
            tmp = tmp?.next
        }
        return result.next
    }
    
    static func printVal(node: ListNode?) {
        guard let node = node else { return }
        print(node.val)
        printVal(node: node.next)
    }
    
    static func tail(_ node: ListNode?) -> ListNode? {
        guard node != nil else { return node }
        if node?.next != nil {
            return ListNode.tail(node?.next)
        } else {
            return node
        }
    }
}

func reverseList(head: ListNode?) -> ListNode? {
    guard let tmpHead = head, tmpHead.next != nil else { return head }
    let newHead = reverseList(head: tmpHead.next)
    tmpHead.next?.next = tmpHead
    tmpHead.next = nil
    return newHead
}

func reverse() {
    let head = ListNode.listNode([1, 2, 3, 4, 5])
    let result = reverseList(head: head)
    head?.next = nil
    ListNode.printVal(node: result)
}


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
cycleListNode1()

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

cycleListNode2()


