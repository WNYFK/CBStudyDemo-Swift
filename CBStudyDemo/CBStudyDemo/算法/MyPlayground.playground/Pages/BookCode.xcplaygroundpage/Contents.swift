//: [Previous](@previous)

import Foundation

public class ListNode: NSObject {
    public var val: Int
    public var next: ListNode?
    
    var tail: ListNode? {
        return ListNode.tail(self)
    }
    
    public init(_ val: Int) {
        self.val = val
        super.init()
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


func swap(i: Int, j: Int, nums: inout [Int]) {
    guard i != j else { return }
    let tmp = nums[i]
    nums[i] = nums[j]
    nums[j] = tmp
}
//: 快排
func QucikSort(nums: inout [Int], start: Int, end: Int) {
    guard nums.count > 1, end > start, nums.count > end else { return }
    let tmp = nums[start]
    var p = start
    var i = start
    while i <= end {
        if nums[i] < tmp {
            p += 1
            swap(i: p, j: i, nums: &nums)
        }
        i += 1
    }
    swap(i: start, j: p, nums: &nums)
    QucikSort(nums: &nums, start: start, end: p)
    QucikSort(nums: &nums, start: p + 1, end: end)
}

var nums = [6, 5, 7, 8, 4, 3, 2]
QucikSort(nums: &nums, start: 0, end: nums.count - 1)

//: 公司员工年龄排序，要求时间复杂度O(n)

func sortAges(_ nums: inout [Int]) {
    var ageTimes: [Int] = Array(repeating: 0, count: 100)
    nums.forEach { (age) in
        guard age < ageTimes.count, age > 0 else {
            fatalError("年龄不合规")
        }
        ageTimes[age] = ageTimes[age] + 1
    }
    nums = []
    ageTimes.enumerated().forEach { (index, times) in
        if times > 0 {
            nums.append(contentsOf: Array(repeating: index, count: times))
            print(times)
        }
    }
}

var ages: [Int] = [23, 45, 66, 23, 34, 45, 45, 67, 68, 67]
sortAges(&ages)
ages

//: 旋转数组的x最小数字（[3 ,4 ,5, ,1 ,2]为[1, 2, 3, 4 ,5]的一个旋转）
func minInOrder(nums: [Int]) -> Int {
    guard nums.count > 0 else {
        fatalError()
    }
    var min = nums[0]
    nums.forEach { (num) in
        if num < min {
            min = num
        }
    }
    return min
}

func minRotate(nums: [Int], start: Int, end: Int) -> Int? {
    guard nums.count > 1, nums.count > start, nums.count > end else { return nums.first }
    guard nums[start] >= nums[end] else { return nums[start] }
    guard end - start > 1 else { return nums[end] }
    let mid = (start + end) / 2
    if nums[start] == nums[mid] && nums[start] == nums[end] {
        return minInOrder(nums: nums)
    } else if nums[mid] >= nums[start] {
        return minRotate(nums: nums, start: mid, end: end)
    } else {
        return minRotate(nums: nums, start: start, end: mid)
    }
}

let ratateNums: [Int] = [2, 2, 2, 3]
let minResult = minRotate(nums: ratateNums, start: 0, end: ratateNums.count - 1)

func min(nums: [Int]) -> Int {
    guard nums.count > 0 else {
        fatalError("数组不能为空")
    }
    var index1 = 0
    var index2 = nums.count - 1
    var indexMid = index1
    while nums[index1] >= nums[index2] {
        if index2 - index1 == 1 {
            indexMid = index2
            break
        }
        indexMid = (index1 + index2) / 2
        if nums[index1] == nums[index2] && nums[index1] == nums[indexMid] {
            return minInOrder(nums: nums)
        } else if nums[indexMid] >= nums[index1] {
            index1 = indexMid
        } else if nums[indexMid] <= nums[index2] {
            index2 = indexMid
        }
    }
    return nums[indexMid]
}

let minResult1 = min(nums: ratateNums)

//: 题9，斐波那契数列
// 大量重复计算
func topic9_0(n: Int) -> Int {
    guard n > 1 else { return n }
    return topic9_0(n: n - 1) + topic9_0(n: n - 2)
}
// O(n)时间复杂度
func topic9_0_f(n: Int) -> Int {
    guard n > 1 else { return n }
    var i: Int = 2
    var value1: Int = 0
    var value2: Int = 1
    while i <= n {
        let result = value1 + value2
        value1 = value2
        value2 = result
        i += 1
    }
    return value2
}

let r9 = topic9_0(n: 9)
let r9_f = topic9_0_f(n: 9)

//: 一只青蛙k一次可以跳1级台阶，也可以跳2级





//: O(1)时间删除链表结点
func deleteListNode(head: inout ListNode?, delNode: inout ListNode?) {
    guard head != nil, delNode != nil else { return }
    if delNode?.next != nil {
        delNode?.val = delNode!.next!.val
        delNode?.next = delNode?.next?.next
    } else if head?.next == nil {
        delNode = nil
        head = nil
    } else {    //删除尾结点
        var p = head
        while p?.next != delNode {
            p = p?.next
        }
        delNode = nil
        p?.next = nil
    }
}

var head1: ListNode? = ListNode(1)
var node2: ListNode? = ListNode(2)
var node3: ListNode? = ListNode(3)
head1?.next = node2
node2?.next = node3

//deleteListNode(head: &head1, delNode: &node2)
print("aaa")
deleteListNode(head: &head1, delNode: &node3)
ListNode.printVal(node: head1)

//: 调整数组顺序使奇数位于偶数前面
func reOrder(nums: inout [Int]) {
    guard nums.count > 1 else { return }
    var left: Int = 0, right: Int = nums.count - 1
    while left < right {
        while left < right && (nums[left] & 1) == 1 {
            left += 1
        }
        while left < right && (nums[right] & 1 == 0) {
            right -= 1
        }
        if (nums[left] & 1) == 0 && (nums[right] & 1 == 1) {
            swap(i: left, j: right, nums: &nums)
            left += 1
            right -= 1
        }
    }
}
var nums1: [Int] = [1, 2, 3, 4, 5, 6]
reOrder(nums: &nums1)
nums1

//: 链表中倒数第k个结点
func findListNode(head: ListNode?, backNum: Int) -> ListNode? {
    guard head != nil, backNum > 0 else { return nil }
    var p1: ListNode?, p2: ListNode? = head
    var count: Int = 1
    while p2?.next != nil {
        p2 = p2?.next
        p1 = p1?.next
        count += 1
        if count == backNum {
            p1 = head
        }
    }
    return p1
}
let fn = findListNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6, 7, 8]), backNum: 1)
fn?.val

//: 反转链表
print("反转链表")
func rollback(head: ListNode?) -> ListNode? {
    guard head != nil, head?.next != nil else { return head }
    let root = rollback(head: head?.next)
    head?.next?.next = head
    head?.next = nil
    return root
}

let rr = rollback(head: ListNode.listNode([1, 2, 3, 4, 5, 6, 7]))

ListNode.printVal(node: rr)

func rollback1(head: ListNode?) -> ListNode? {
    guard head?.next != nil else { return head }
    var newHead: ListNode? = head, p1 = head?.next
    var p2 = p1?.next
    newHead?.next = nil
    while p1 != nil {
        p1?.next = newHead
        newHead = p1
        p1 = p2
        p2 = p1?.next
    }
    return newHead
}

let rr1 = rollback(head: ListNode.listNode([1]))
ListNode.printVal(node: rr1)

//: 合并两个递增排序的列表
print("合并两个链表")
func merge(head1: ListNode?, head2: ListNode?) -> ListNode? {
    guard let head1 = head1 else { return head2 }
    guard let head2 = head2 else { return head1 }
    var newHead: ListNode?, p1: ListNode?, p2: ListNode?, p: ListNode?
    if head2.val > head1.val {
        newHead = head1
        p1 = head1.next
        p2 = head2
    } else {
        newHead = head2
        p2 = head2.next
        p1 = head1
    }
    p = newHead
    while p1 != nil, p2 != nil {
        if p1!.val > p2!.val {
            p?.next = p2
            p2 = p2?.next
        } else {
            p?.next = p1
            p1 = p1?.next
        }
        p = p?.next
    }
    if p1 != nil {
        p?.next = p1
    } else if p2 != nil {
        p?.next = p2
    }
    return newHead
}
let rm = merge(head1: ListNode.listNode([1, 2, 3, 4, 5]), head2: ListNode.listNode([2, 4, 5, 6, 7]))
ListNode.printVal(node: rm)

print("合并两个链表递归")

func merge1(head1: ListNode?, head2: ListNode?) -> ListNode? {
    guard let head1 = head1 else { return head2 }
    guard let head2 = head2 else { return head1 }
    var newHead: ListNode?
    if head1.val > head2.val {
        newHead = head2
        newHead?.next = merge(head1: head1, head2: head2.next)
    } else {
        newHead = head1
        newHead?.next = merge(head1: head1.next, head2: head2)
    }
    return newHead
}
let rm1 = merge1(head1: ListNode.listNode([1, 2, 3, 4, 5]), head2: ListNode.listNode([2, 4, 5, 6, 7]))
ListNode.printVal(node: rm1)

//: 树的子结构：输入两个二叉树A和B， 判断B是不是A的子结构
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    func inorder() -> [Int] {
        return [self.val] + (self.left?.inorder() ?? []) + (self.right?.inorder() ?? [])
    }
}

print("判断树的子结构")
func isSubTree(head1: TreeNode?, head2: TreeNode?) -> Bool {
    if head2 == nil { return true }
    if head1 == nil && head2 != nil { return false }
    if head1?.val == head2?.val, containTree2(head1: head1, head2: head2) {
        return true
    }
    if isSubTree(head1: head1?.left, head2: head2) {
        return true
    } else {
        return isSubTree(head1: head1?.right, head2: head2)
    }
}
func containTree2(head1: TreeNode?, head2: TreeNode?) -> Bool {
    guard let head2 = head2 else { return true }
    guard let head1 = head1 else { return false }
    guard head1.val == head2.val else { return false }
    return containTree2(head1: head1.left, head2: head2.left) && containTree2(head1: head1.right, head2: head2.right)
}
let tree1 = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 6))
let subTree1 = TreeNode(val: 2, left: nil, right: TreeNode(val: 5))
let treeResult = isSubTree(head1: tree1, head2: subTree1)

//: 二叉树镜像
print("二叉树镜像")

func mirroring(head: TreeNode?) -> TreeNode? {
    guard head != nil else { return nil }
    let left = head?.left
    head?.left = mirroring(head: head?.right)
    head?.right = mirroring(head: left)
    return head
}

let tree_mirr = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 3, left: TreeNode(val: 6)))
let mirr_result1 = mirroring(head: tree_mirr)
mirr_result1?.inorder()
tree_mirr.inorder()

func mirroring1(head: TreeNode?) {
    guard let head = head else { return }
    var arr: [TreeNode] = [head]
    var i: Int = 0
    while i < arr.count {
        let node = arr[i]
        let left = node.left
        if let left = left {
            arr.append(left)
        }
        if let right = node.right {
            arr.append(right)
        }
        node.left = node.right
        node.right = left
        i += 1
    }
}
mirroring1(head: tree_mirr)
tree_mirr.inorder()


//: 顺时针打印矩阵
print("顺时针打印矩阵")

//: 包含min函数的栈：定义栈的数据结构，实现min,push,pop的时间复杂度都是o(1)
print("定义栈")
class CBStack {
    private var oriStack: [Int] = []
    private var minStack: [Int] = []
    
    func min() -> Int? {
        return minStack.last
    }
    
    func push(value: Int) {
        oriStack.append(value)
        if let min = min(), min < value {
            minStack.append(min)
        } else {
            minStack.append(value)
        }
    }
    
    func pop() -> Int? {
        minStack.removeLast()
        return oriStack.removeLast()
    }
    
    var allValues: [Int] {
        return oriStack
    }
}

let stack = CBStack()
stack.push(value: 1)
stack.push(value: 2)
stack.push(value: 3)
stack.push(value: 4)
let min = stack.min()
stack.allValues
stack.pop()


//: 栈的压入、弹出序列: 1 ，2， 3， 4， 5 的一个弹出序列：4， 5， 3， 2， 1
func isPopOrder(pushNums: [Int], popNums: [Int]) -> Bool {
    guard pushNums.count == popNums.count else { return false }
    var stack: [Int] = []
    var i: Int = 0
    for num in popNums {
        if num == stack.last {
            stack.removeLast()
        } else if pushNums.count > i {
            if pushNums[i] == num {
                i += 1
            } else {
                while i < pushNums.count {
                    if pushNums[i] == num {
                        i += 1
                        break
                    }
                    stack.append(pushNums[i])
                    i += 1
                }
            }
        }
    }
    return stack.isEmpty
}

let rs = isPopOrder(pushNums: [1, 2, 3, 4, 5], popNums: [4, 5, 3, 2, 1])

//: 从上往下打印二叉树:同一层的结点按照从左到右的顺序打印
print("二叉树的打印")

func printTree(head: TreeNode?) {
    guard let head = head else { return }
    var stack: [TreeNode] = [head]
    var i: Int = 0
    while i < stack.count {
        let node = stack[i]
        print(node.val)
        if let left = node.left {
            stack.append(left)
        }
        if let right = node.right {
            stack.append(right)
        }
        i += 1
    }
}

let tree = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 3, left: TreeNode(val: 6)))

printTree(head: tree)

//: 二叉树的后续遍历
func flowup(head: TreeNode?) -> [Int] {
    guard let head = head else { return [] }
    return flowup(head: head.left) + flowup(head: head.right) + [head.val]
}

let flowupResult = flowup(head: tree)

// 输入一个数组，判断该数组是不是某二叉搜索树的后续遍历

func isFlowup(nums: [Int], start: Int, end: Int) -> Bool {
    guard nums.count > 1, nums.count > end, end > start else { return true }
    let root = nums[end]
    var leftIndex: Int = start
    while leftIndex < end {
        if nums[leftIndex] > root {
            break
        }
        leftIndex += 1
    }
    var rightIndex = leftIndex
    while rightIndex < end {
        if nums[rightIndex] < root {
            return false
        }
        rightIndex += 1
    }
    var leftResult = true
    if leftIndex - 1 > start {
        leftResult = isFlowup(nums: nums, start: start, end: leftIndex - 1)
    }
    var rightResult = true
    if leftIndex < end - 1 {
        rightResult = isFlowup(nums: nums, start: leftIndex, end: end - 1)
    }
    return leftResult && rightResult
}

let rr11 = isFlowup(nums: [7, 4, 6, 5], start: 0, end: 3)

// 前序遍历

func preorder(head: TreeNode?) {
    guard let head = head else { return }
    var stack: [TreeNode] = []
    var root: TreeNode? = head
    var result: [Int] = []
    while !stack.isEmpty || root != nil {
        while root != nil {
            stack.append(root!)
            result.append(root!.val)
            root = root?.left
        }
        if !stack.isEmpty {
            root = stack.removeLast()
            root = root?.right
        }
    }
    print("前序:\(result)")
}

preorder(head: TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 3, left: TreeNode(val: 6))))

// 中序遍历
func InOrder(head: TreeNode?) {
    guard let head = head else { return }
    var stack: [TreeNode] = []
    var result: [Int] = []
    var root: TreeNode? = head
    while !stack.isEmpty || root != nil {
        while root != nil {
            stack.append(root!)
            root = root?.left
        }
        if !stack.isEmpty {
            root = stack.removeLast()
            result.append(root!.val)
            root = root?.right
        }
    }
    print("中序：\(result)")
}
InOrder(head: TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 3, left: TreeNode(val: 6))))


//: 二叉树中和为某一值的路径:输入一颗二叉树和一个整数，打印出二叉树中结点值和为输入整数的所有路径，从树的根结点开始
print("二叉树路径")
func findPath(head: TreeNode?, paths: [Int], curSum: Int, sum: Int) {
    guard let head = head else { return }
    let paths = paths + [head.val]
    let curSum = curSum + head.val
    if curSum == sum, head.left == nil, head.right == nil {
        print("路径：\(paths)")
    }
    findPath(head: head.left, paths: paths, curSum: curSum, sum: sum)
    findPath(head: head.right, paths: paths, curSum: curSum, sum: sum)
}
findPath(head: TreeNode(val: 10, left: TreeNode(val: 5, left: TreeNode(val: 4), right: TreeNode(val: 7)), right: TreeNode(val: 12)), paths: [], curSum: 0, sum: 22)

//: 复制复杂链表
class ComplexListNode {
    var val: Int
    var next: ComplexListNode?
    var sibling: ComplexListNode?
    
    init(val: Int) {
        self.val = val
    }
}

let lnode1 = ComplexListNode(val: 1)
let lnode2 = ComplexListNode(val: 2)
let lnode3 = ComplexListNode(val: 3)
let lnode4 = ComplexListNode(val: 4)
lnode1.next = lnode2
lnode2.next = lnode3
lnode3.next = lnode4
lnode1.sibling = lnode3
lnode2.sibling = lnode1
lnode4.sibling = lnode3

func copyNode(head: ComplexListNode?) {
    guard let head = head else { return }
    let node = ComplexListNode(val: head.val)
    node.next = head.next
    head.next = node
    copyNode(head: node.next)
}

func copySibling(head: ComplexListNode?) {
    guard let head = head else { return }
    head.next?.sibling = head.sibling?.next
    copySibling(head: head.next?.next)
}

func sepList(head: ComplexListNode?) -> (ComplexListNode?, ComplexListNode?) {
    guard let head = head else { return (nil, nil) }
    let p1 = head
    let p2 = head.next
    let nextTup = sepList(head: p2?.next)
    p1.next = nextTup.0
    p2?.next = nextTup.1
    return (p1, p2)
    
}

func copy(head: ComplexListNode?) -> ComplexListNode? {
    guard let head = head else { return nil }
    copyNode(head: head)
    copySibling(head: head)
    let tup = sepList(head: head)
    return tup.1
}

let lnR = copy(head: lnode1)

lnR?.val
lnR?.sibling?.val

lnR?.next?.val
lnR?.next?.sibling?.val

lnR?.next?.next?.val
lnR?.next?.next?.sibling?.val

lnR?.next?.next?.next?.val
lnR?.next?.next?.next?.sibling?.val

// 二叉搜索树转化为双向链表
print("二叉搜索树转化为双向链表")
func convert(head: TreeNode?, isLeft: Bool) -> TreeNode? {
    guard let head = head else { return nil }
    let left = convert(head: head.left, isLeft: true)
    let right = convert(head: head.right, isLeft: false)
    head.left = left
    left?.right = head
    head.right = right
    right?.left = head
    return isLeft ? (right ?? head) : (left ?? head)
}

let tree11 = TreeNode(val: 10, left: TreeNode(val: 6, left: TreeNode(val: 4), right: TreeNode(val: 8)), right: TreeNode(val: 14, left: TreeNode(val: 12), right: TreeNode(val: 16)))
let resultConvert = convert(head: tree11, isLeft: true)
var tmpNode = resultConvert
while tmpNode != nil {
    if tmpNode?.left != nil {
        tmpNode = tmpNode?.left
    } else {
        break
    }
}
var resultVals: [Int] = []
while tmpNode != nil {
    resultVals.append(tmpNode!.val)
    if tmpNode?.right != nil {
        tmpNode = tmpNode?.right
    } else {
        break
    }
}
print(resultVals)
resultVals = []
while tmpNode != nil {
    resultVals.append(tmpNode!.val)
    tmpNode = tmpNode?.left
}

print(resultVals)

// 数组中出现次数超过一半的数字
print("数组中出现次数超过一半的数字")

func partition(nums: inout [Int], start: Int, end: Int) -> Int {
    if nums.isEmpty || start > end || nums.count < end {
        fatalError()
    }
    let compare = nums[start]
    var i = start, j = start
    while j <= end  {
        if nums[j] < compare {
            i += 1
            swap(i: i, j: j, nums: &nums)
        }
        j += 1
    }
    swap(i: start, j: i, nums: &nums)
    return i
}

func QuickSort1(nums: inout [Int], start: Int, end: Int) {
    if nums.isEmpty || end < start, nums.count < end, nums.count < start {
        fatalError()
    }
    let mid = partition(nums: &nums, start: start, end: end)
    if mid > start {
        QuickSort1(nums: &nums, start: start, end: mid - 1)
    }
    if mid < end {
        QuickSort1(nums: &nums, start: mid + 1, end: end)
    }
}
var nums11: [Int] = [5, 7, 6, 4, 3, 8, 9]
QuickSort1(nums: &nums11, start: 0, end: nums11.count - 1)

func checkMoreThanHalf(nums: [Int], num: Int) -> Bool {
    let times = nums.reduce(0, { $0 + ($1 == num ? 1 : 0) })
    return times >= nums.count / 2
}

func moreHalf(nums: inout [Int]) {
    guard !nums.isEmpty else { return }
    var index = partition(nums: &nums, start: 0, end: nums.count - 1)
    let mid = nums.count >> 1
    while index != mid {
        if index > mid {
            index = partition(nums: &nums, start: 0, end: index - 1)
        } else {
            index = partition(nums: &nums, start: index + 1, end: nums.count - 1)
        }
    }
    if index < 0 || index > nums.count {
        fatalError()
    }
    print("超过一半的数为：\(nums[index])")
}
var halfNums: [Int] = [1, 1, 2, 2, 2, 2, 3, 5, 2]
moreHalf(nums: &halfNums)

func moreHalf1(nums: [Int]) {
    guard !nums.isEmpty else { return }
    var num: Int = nums[0]
    var count = 1
    for item in nums {
        if num == item {
            count += 1
        } else {
            count -= 1
            if count == 0 {
                num = item
                count = 1
            }
        }
    }
    print("超过一半数字为: \(num)")
}
moreHalf1(nums: halfNums)

//  最小的k个数
print("最小的k个数")

func minNums(nums: inout [Int], k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0, nums.count > k else { return [] }
    var start: Int = 0, end: Int = nums.count - 1
    var index = partition(nums: &nums, start: start, end: end)
    while index != k - 1 {
        if index > k - 1 {
            end = index - 1
            index = partition(nums: &nums, start: start, end: end)
        } else {
            start = index + 1
            index = partition(nums: &nums, start: start, end: end)
        }
    }
    return Array(nums.prefix(k))
}

var minNums: [Int] = [5, 4, 3, 6, 7, 2, 1, 9]
let minR = minNums(nums: &minNums, k: 4)
minNums

// 连续子数组的最大和
func maxSum(nums: [Int]) -> Int {
    guard nums.count > 1 else { return nums.first ?? 0 }
    var maxSum: Int = -LONG_MAX, sum: Int = 0
    for num in nums {
        if sum < 0 {
            sum = num
        } else {
            sum += num
        }
        if sum > maxSum {
            maxSum = sum
        }
    }
    return maxSum
}

let maxRR = maxSum(nums: [-1, -1, 1])

// 把数组排成x最小的数
func getMinNum(nums: [Int]) {
    var nums = nums
    QuickSortNew(nums: &nums, start: 0, end: nums.count - 1)
    let result = nums.map(String.init).joined(separator: "")
    print("最小值为：\(result)")
    
}

func partitonNew(nums: inout [Int], start: Int, end: Int) -> Int {
    if nums.isEmpty || start > end || nums.count <= end {
        fatalError()
    }
    let comp = nums[start]
    var i: Int = start, j: Int = start
    while j <= end {
        if leftBig(left: comp, right: nums[j]) {
            i += 1
            swap(i: i, j: j, nums: &nums)
        }
        j += 1
    }
    swap(i: i, j: start, nums: &nums)
    return i
}

func QuickSortNew(nums: inout [Int], start: Int, end: Int) {
    if nums.isEmpty || start > end || nums.count <= end {
        fatalError()
    }
    let index = partitonNew(nums: &nums, start: start, end: end)
    if index + 1 < end {
        QuickSortNew(nums: &nums, start: index + 1, end: end)
    }
    if index - 1 > start {
        QuickSortNew(nums: &nums, start: start, end: index - 1)
    }
}

func leftBig(left: Int, right: Int) -> Bool {
    let lr = Int("\(left)\(right)") ?? 0
    let rl = Int("\(right)\(left)") ?? 0
    return lr > rl
}
getMinNum(nums: [3, 32, 321])

//: 两个链表第一个公共结点
func getListLength(head: ListNode?) -> Int {
    guard let head = head else { return 0 }
    return 1 + getListLength(head: head.next)
}

func getListNode(head: ListNode?, k: Int) -> ListNode? {
    guard k > 1 else { return head }
    return getListNode(head: head?.next, k: k - 1)
}

func listSameNode(head1: ListNode?, head2: ListNode?) {
    guard let head1 = head1, let head2 = head2 else { return }
    let l1 = getListLength(head: head1)
    let l2 = getListLength(head: head2)
    var p1: ListNode? = head1, p2: ListNode? = head2
    let diff = l1 - l2
    if diff > 0 { // head1更长
        p1 = getListNode(head: head1, k: diff + 1)
    } else if diff < 0 { // head2更长
        p2 = getListNode(head: head2, k: -diff + 1)
    }
    while p1 != nil, p2 != nil {
        if p1 == p2 {
            print("公共结点为:\(p1!.val)===\(p2!.val)")
            break
        }
        p1 = p1?.next
        p2 = p2?.next
    }
}
let nd1 = ListNode(5)
let nd2 = ListNode(6)
nd1.next = nd2

let node11 = ListNode(1)
let node12 = ListNode(2)
node11.next = node12
node12.next = nd1

let node21 = ListNode(4)
let node22 = ListNode(9)
let node23 = ListNode(10)
node21.next = node22
node22.next = node23
node23.next = nd1
listSameNode(head1: node11, head2: node21)


// 数字在排序数组中出现的次数

func getFirstK(nums: [Int], k: Int, start: Int, end: Int) -> Int {
    guard !nums.isEmpty, nums.count > end, nums.count > start, end >= start else { return -1 }
    var s = start, e = end
    let midIndex = (s + e) / 2
    let midValue = nums[midIndex]
    if midValue == k {
        if (midIndex > start && nums[midIndex - 1] != k) || midIndex == start {
            return midIndex
        }
        e = midIndex - 1
    } else if midValue > k {
        e = midIndex - 1
    } else {
        s = midIndex + 1
    }
    return getFirstK(nums: nums, k: k, start: s, end: e)
}

func getLastK(nums: [Int], k: Int, start: Int, end: Int) -> Int {
    guard !nums.isEmpty, nums.count > end, nums.count > start, end > start else { return -1 }
    var s = start, e = end
    let midIndex = (s + e) / 2
    let midValue = nums[midIndex]
    if midValue == k {
        if (midIndex < end && nums[midIndex + 1] != k) || midIndex == e {
            return midIndex
        }
        s = midIndex + 1
    } else if midValue > k {
        e = midIndex - 1
    } else {
        s = midIndex + 1
    }
    return getLastK(nums: nums, k: k, start: s, end: e)
}

func getKCount(nums: [Int], k: Int) -> Int {
    let firstIndex = getFirstK(nums: nums, k: k, start: 0, end: nums.count - 1)
    let endIndex = getLastK(nums: nums, k: k, start: 0, end: nums.count - 1)
    if endIndex - firstIndex >= 0 {
        return endIndex - firstIndex + 1
    }
    return 0
}
var knums: [Int] = [1, 2, 3, 3, 3, 3, 4, 5]
getKCount(nums: knums, k: 3)

// 二叉树的深度
print("二叉树的深度")
func treeHeight(head: TreeNode?) -> Int {
    guard let head = head else { return 0 }
    let leftHeight = treeHeight(head: head.left)
    let rightHeight = treeHeight(head: head.right)
    return max(leftHeight, rightHeight) + 1
}

treeHeight(head: TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 3), right: TreeNode(val: 4)), right: TreeNode(val: 7, left: TreeNode(val: 3), right: TreeNode(val: 8, left: TreeNode(val: 10, left: TreeNode(val: 9), right: TreeNode(val: 7)), right: nil))))

// 判断一颗树是不是平衡二叉树

func isBalanced(head: TreeNode?) -> Bool {
    guard let head = head else { return true }
    let leftHeight = treeHeight(head: head.left)
    let rightHeight = treeHeight(head: head.right)
    let diff = leftHeight - rightHeight
    if diff > 1 || diff < -1 {
        return false
    }
    return isBalanced(head: head.left) && isBalanced(head: head.right)
}

func isBalanced1(head: TreeNode?, height: inout Int) -> Bool {
    guard let head = head else {
        height = 0
        return true
    }
    var left: Int = 0, right: Int = 0
    if isBalanced1(head: head.left, height: &left) && isBalanced1(head: head.right, height: &right) {
        let diff = left - right
        if diff > 1 || diff < -1 {
            return false
        }
        height = max(left, right) + 1
        return true
    }
    return false
}

// LRU
extension LRUCache {
    class Node<K: Hashable, T> {
        let key: K
        let obj: T
        var next: Node?
        var pre: Node?
        
        init(key: K, obj: T) {
            self.key = key
            self.obj = obj
        }
    }
}

class LRUCache<K: Hashable, T> {
    private var head: Node<K, T>?
    private var tail: Node<K, T>?
    private var dict: [K: Node<K, T>] = [:]
    private let length: Int
    private var curLength: Int = 0
    private let queue = DispatchQueue(label: "com.cb.lrucache", qos: DispatchQoS.userInitiated, attributes: .concurrent)
    
    init(length: Int) {
        self.length = length
    }
    
    func put(key: K, value: T) {
        let barrierItem = DispatchWorkItem(qos: .userInitiated, flags: .barrier) {
            let node = Node(key: key, obj: value)
            if self.head == nil && self.tail == nil {
                self.head = node
                self.tail = self.head
                self.curLength = 1
            } else if self.curLength == self.length {
                if let delKey = self.head?.key {
                    self.dict.removeValue(forKey: delKey)
                }
                self.head = self.head?.next
                self.head?.pre?.next = nil
                self.head?.pre = nil
                self.tail?.next = node
                node.pre = self.tail
                self.tail = node
            } else {
                self.tail?.next = node
                node.pre = self.tail
                self.tail = node
                self.curLength += 1
            }
            self.dict[key] = node
            self.printAll()
        }
        queue.async(execute: barrierItem)
    }
    func get(key: K) -> Node<K, T>? {
        var result: Node<K, T>?
        queue.sync {
            result = self.dict[key]
        }
        return result
    }
    
    func printAll() {
        var result: [T] = []
        var p = head
        while p != nil {
            result.append(p!.obj)
            p = p?.next
        }
        print("所有缓存:\(result)")
    }
}

let cache = LRUCache<Int, Int>(length: 3)
cache.get(key: 1)?.obj
cache.put(key: 1, value: 10)
cache.put(key: 2, value: 20)
cache.put(key: 3, value: 30)
cache.put(key: 4, value: 40)
cache.get(key: 1)
cache.get(key: 2)

// 旋转数组
func rotationArray(nums: [Int]) -> Int {
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
        if nums[left] == nums[mid] && nums[right] == nums[mid] {
            return minInOrder(nums: nums)
        }
        if nums[mid] > nums[left] {
            left = mid
        } else {
            right = mid
        }
    }
    return nums[mid]
}

func minInorder(nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var result = nums[0]
    for num in nums {
        if result < num {
            result = num
        }
    }
    return result
}

rotationArray(nums: [3, 4, 5, 1, 2, 3])

// 从尾到到打印链表
print("从尾到头打印链表")
func printListNode(head: ListNode?) {
    guard let head = head else { return }
    printListNode(head: head.next)
    print("\(head.val)")
}

printListNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]))

// 二进制1的个数
func numberOf1(num: Int) {
    var count: Int = 0, flag: Int = 1
    while flag != 0 {
        if (num & flag) != 0 {
            count += 1
        }
        flag = flag << 1
    }
    print("1的个数: \(count)")
}
numberOf1(num: 11)

func numberOf1_1(num: Int) {
    var n = num, count: Int = 0
    while n != 0 {
        count += 1
        n = n & (n - 1)
    }
    print("1的个数: \(count)")
}
numberOf1_1(num: 11)
//
func rollbackListNode(head: ListNode?) -> ListNode? {
    guard let tmpHead = head, tmpHead.next != nil else { return head }
    let newHead = rollbackListNode(head: tmpHead.next)
    tmpHead.next?.next = tmpHead
    tmpHead.next = nil
    return newHead
}

let newHead = rollbackListNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]))
ListNode.printVal(node: newHead)

// 合并两个排序链表
func mergeListNode(head1: ListNode?, head2: ListNode?) -> ListNode? {
    guard let head1 = head1 else { return head2 }
    guard let head2 = head2 else { return head1 }
    var newHead: ListNode?
    if head1.val > head2.val {
        newHead = head2
        newHead?.next = mergeListNode(head1: head1, head2: head2.next)
    } else {
        newHead = head1
        newHead?.next = mergeListNode(head1: head1.next, head2: head2)
    }
    return newHead
}

let mergedHead = mergeListNode(head1: ListNode.listNode([1, 2, 3, 5, 6]), head2: ListNode.listNode([2, 8, 9, 10]))
print("合并后：")
ListNode.printVal(node: mergedHead)

// 两两交换链表中的结点 :给定 1->2->3->4, 你应该返回 2->1->4->3.

func exchange(head: ListNode?) -> ListNode? {
    guard let tmpHead = head, tmpHead.next != nil else { return head }
    let next = head?.next
    tmpHead.next = exchange(head: next?.next)
    next?.next = tmpHead
    return next
}

let exgHead = exchange(head: ListNode.listNode([1, 2, 3, 4]))
ListNode.printVal(node: exgHead)

// 链表中倒数第K个数

func getBackNode(head: ListNode?, k: Int) -> ListNode? {
    guard let head = head, k > 0 else { return nil }
    var p1: ListNode? = head, p2: ListNode? = head
    var i = 0
    while i < k - 1 {
        if p1?.next != nil {
            p1 = p1?.next
            i += 1
        } else {
            return nil
        }
    }
    while p1?.next != nil {
        p1 = p1?.next
        p2 = p2?.next
    }
    return p2
}
getBackNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]), k: 2)?.val
getBackNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]), k: 1)?.val
getBackNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]), k: 4)?.val
getBackNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]), k: 6)?.val
getBackNode(head: ListNode.listNode([1, 2, 3, 4, 5, 6]), k: 7)?.val

// 反转链表
func rollbackListNode1(head: ListNode?) -> ListNode? {
    guard let tmpHead = head, tmpHead.next != nil else { return head }
    let next = rollbackListNode1(head: head?.next)
    tmpHead.next?.next = tmpHead
    tmpHead.next = nil
    return next
}

print("链表反转")
let rbHead = rollbackListNode1(head: ListNode.listNode([1, 2, 3, 4, 5, 6]))
ListNode.printVal(node: rbHead)

// 树的子结构
func isSubTree1(head1: TreeNode?, head2: TreeNode?) -> Bool {
    guard let head1 = head1 else { return false }
    guard let head2 = head2 else { return true }
    var result = false
    if head1.val == head2.val {
        result = isContainTree(head1: head1, head2: head2)
    }
    if !result {
        result = isSubTree1(head1: head1.left, head2: head2)
    }
    if !result {
        result = isSubTree1(head1: head1.right, head2: head2)
    }
    return result
}

func isContainTree(head1: TreeNode?, head2: TreeNode?) -> Bool {
    guard let head2 = head2 else { return true }
    guard let head1 = head1 else { return false }
    return head1.val == head2.val && isContainTree(head1: head1.left, head2: head2.left) && isContainTree(head1: head1.right, head2: head2.right)
}

func testSubTree() {
    let tree = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 3), right: TreeNode(val: 4)), right: TreeNode(val: 5))
    let subTree = TreeNode(val: 2, left: TreeNode(val: 4), right: nil)
    isSubTree1(head1: tree, head2: subTree)
}
testSubTree()

// 二叉树的镜像 递归
func treePic(head: TreeNode?) -> TreeNode? {
    guard let head = head else { return nil }
    let left = head.left
    head.left = treePic(head: head.right)
    head.right = treePic(head: left)
    return head
}

func testTreePic() {
    let tree = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 3), right: TreeNode(val: 4)), right: TreeNode(val: 5))
    preorder(head: tree)
    preorder(head: treePic(head: tree))
}
testTreePic()

// 二叉树镜像 非递归
func treePic1(head: TreeNode?) -> TreeNode? {
    guard let head = head else { return nil }
    var stack: [TreeNode] = [head]
    var i: Int = 0
    while i < stack.count {
        let node = stack[i]
        let left = node.left
        let right = node.right
        if let left = left {
            stack.append(left)
        }
        if let right = right {
            stack.append(right)
        }
        node.left = right
        node.right = left
        i += 1
        
    }
    return head
}
func testTreePic1() {
    let tree = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 3), right: TreeNode(val: 4)), right: TreeNode(val: 5))
     preorder(head: tree)
     preorder(head: treePic1(head: tree))
}
testTreePic1()

// 后续遍历
func followUpOrder(head: TreeNode?) -> [Int] {
    guard let head = head else { return [] }
    return followUpOrder(head: head.left) + followUpOrder(head: head.right) + [head.val]
}
func testFollowupOrder() {
    let treeHead = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 3), right: TreeNode(val: 4)), right: TreeNode(val: 5))
    followUpOrder(head: treeHead)
}
testFollowupOrder()

// 二叉树中和为某一值的路径
func treePath(head: TreeNode?, paths: [Int], sum: Int, curSum: Int) {
    guard let head = head else { return }
    if curSum + head.val == sum, head.left == nil, head.right == nil {
        print("和为\(sum)的路径:\(paths + [head.val])")
    }
    treePath(head: head.left, paths: paths + [head.val], sum: sum, curSum: curSum + head.val)
    treePath(head: head.right, paths: paths + [head.val], sum: sum, curSum: curSum + head.val)
}
func testTreePath() {
    let treeNode = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 3))
    treePath(head: treeNode, paths: [], sum: 7, curSum: 0)
}
testTreePath()

// 验证二叉搜索树
func isValidBST(head: TreeNode?) -> Bool {
    guard let head = head else { return true }
    var result = true
    if let left = head.left {
        result = head.val >= left.val
    }
    if let right = head.right {
        result = result && (right.val >= head.val)
    }
    return result && isValidBST(head: head.left) && isValidBST(head: head.right)
}

func testValidBST() {
    let tree1 = TreeNode(val: 2, left: TreeNode(val: 1), right: TreeNode(val: 3))
    let tree2 = TreeNode(val: 5, left: TreeNode(val: 1), right: TreeNode(val: 4, left: TreeNode(val: 3), right: TreeNode(val: 6)))
    isValidBST(head: tree1)
    isValidBST(head: tree2)
}
testValidBST()

func findLowestAncestor(head: TreeNode?, nv1: Int, nv2: Int) -> TreeNode? {
    if head == nil || head?.val == nv1 || head?.val == nv2 {
        return head
    }
    let left = findLowestAncestor(head: head?.left, nv1: nv1, nv2: nv2)
    let right = findLowestAncestor(head: head?.right, nv1: nv1, nv2: nv2)
    if left == nil, right == nil {
        return nil
    } else if left != nil, right == nil {
        return left
    } else if left == nil, right != nil {
        return right
    }
    return head
}

func testLowestAncestor() {
    let tree2 = TreeNode(val: 5, left: TreeNode(val: 1), right: TreeNode(val: 4, left: TreeNode(val: 3), right: TreeNode(val: 6)))
    findLowestAncestor(head: tree2, nv1: 6, nv2: 4)?.val
}
testLowestAncestor()






//: [Next](@next)
