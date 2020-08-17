//: [Previous](@previous)

import Foundation

class TreeNode: NSObject {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        super.init()
        self.left = left
        self.right = right
    }
}

// 二叉树的环
func isInArray(nodes: [TreeNode], node: TreeNode) -> Bool {
    return nodes.contains(where: { $0 == node })
}

func hasCycle(head: TreeNode?) -> Bool {
    guard head != nil else { return false }
    var arr: [TreeNode] = [head!]
    var i = 0
    while i < arr.count {
        let node = arr[i]
        if let leftNode = node.left {
            if isInArray(nodes: arr, node: leftNode) {
                return true
            }
            arr.append(leftNode)
        }
        if let rightNode = node.right {
            if isInArray(nodes: arr, node: rightNode) {
                return true
            }
            arr.append(rightNode)
        }
        i += 1
    }
    return false
}

let cTnode = TreeNode(val: 10)
let tree11 = TreeNode(val: 3, left: TreeNode(val: 4, left: TreeNode(val: 5), right: cTnode), right: TreeNode(val: 30))
cTnode.right = tree11
let rr = hasCycle(head: tree11)

func hasCycle1(head: TreeNode?, dict: inout [TreeNode: Int]) -> Bool {
    guard let node = head else { return false }
    if dict[node] == 1 {
        return true
    }
    if hasCycle(head: node.left) || hasCycle(head: node.right) {
        return true
    }
    return false
}
var dict: [TreeNode: Int] = [:]
let rr1 = hasCycle1(head: tree11, dict: &dict)

// 查找二维数组中的岛屿个数：1代表陆地，0代表海水，1聚集的地方形成一个岛屿

func islandCount(arr: inout [[Int]]) -> Int {
    guard !arr.isEmpty else { return 0 }
    let m: Int = arr.count, n: Int = arr[0].count
    var i = 0, j = 0, count = 0
    while i < m {
        j = 0
        while j < n {
            if arr[i][j] == 1 {
                count += 1
                convertToZero(arr: &arr, i: i, j: j)
            }
            j += 1
        }
        i += 1
    }
    return count
}

func convertToZero(arr: inout [[Int]], i: Int, j: Int) {
    guard !arr.isEmpty else { return }
    guard i >= 0, j >= 0, arr.count > i, arr[0].count > j else { return }
    guard arr[i][j] == 1 else { return }
    arr[i][j] = 0
    convertToZero(arr: &arr, i: i, j: j - 1)
    convertToZero(arr: &arr, i: i - 1, j: j)
    convertToZero(arr: &arr, i: i, j: j + 1)
    convertToZero(arr: &arr, i: i + 1, j: j)
}
var arr1: [Int] = [1, 0, 1, 0]
var arr2: [Int] = [0, 1, 1, 0]
var arr3: [Int] = [1, 0, 0, 0]
var arr4: [Int] = [0, 0, 0, 0]
var arr = [arr1, arr2, arr3, arr4]

let count = islandCount(arr: &arr)

// 旋转数组的最小数字
func minNum(nums: [Int]) -> Int {
    if nums.isEmpty {
        fatalError()
    }
    var left: Int = 0, right: Int = nums.count - 1
    var mid = left
    while nums[left] >= nums[right] {
        if right - left == 1 {
            mid = right
            break
        }
        mid = (left + right) >> 1
        if nums[left] == nums[right], nums[left] == nums[mid] {
            return findMin(nums: nums)
        }
        if nums[mid] >= nums[left] {
            left = mid
        } else {
            right = mid
        }
    }
    return nums[mid]
}

func findMin(nums: [Int]) -> Int {
    if nums.isEmpty {
        fatalError()
    }
    var min = nums[0]
    for num in nums {
        if num < min {
            min = num
        }
    }
    return min
}

minNum(nums: [3, 4, 5, 1, 2, 3])
minNum(nums: [1, 1, 1, 0, 1])

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

// 链表倒数第K个结点
func findBackNum(head: ListNode?, k: Int) -> ListNode? {
    guard let head = head, k > 0 else { return nil }
    var p1: ListNode? = head
    var i: Int = 0
    while i < (k - 1) {
        if p1?.next != nil {
            p1 = p1?.next
        } else {
            return nil
        }
        i += 1
    }
    var p2: ListNode? = head
    while p1?.next != nil {
        p1 = p1?.next
        p2 = p2?.next
    }
    return p2
}
findBackNum(head: ListNode.listNode([1, 2, 3, 4, 5, 6, 7, 8, 9]), k: 1)?.val
findBackNum(head: ListNode.listNode([1, 2, 3, 4, 5, 6, 7, 8, 9]), k: 2)?.val
findBackNum(head: ListNode.listNode([1, 2, 3, 4, 5, 6, 7, 8, 9]), k: 9)?.val

// 反转链表
func rollback(head: ListNode?) -> ListNode? {
    guard let tmpHead = head, tmpHead.next != nil else { return head }
    let newHead = rollback(head: tmpHead.next)
    tmpHead.next?.next = tmpHead
    tmpHead.next = nil
    return newHead
}
let newHead = rollback(head: ListNode.listNode([1, 2, 3, 4, 5, 6, 7, 8]))
//ListNode.printVal(node: newHead)

// 合并两个l有序链表
func merge(head1: ListNode?, head2: ListNode?) -> ListNode? {
    guard let head1 = head1 else { return head2 }
    guard let head2 = head2 else { return head1 }
    if head1.val < head2.val {
        head1.next = merge(head1: head1.next, head2: head2)
        return head1
    } else {
        head2.next = merge(head1: head1, head2: head2.next)
        return head2
    }
}
let newHead1 = merge(head1: ListNode.listNode([1, 2, 3, 4, 5, 6]), head2: ListNode.listNode([2, 3, 4, 5, 6, 7]))
ListNode.printVal(node: newHead1)





//: [Next](@next)
