//: [Previous](@previous)

import Foundation

func == (lhs: TreeNode?, rhs: TreeNode?) -> Bool {
    return lhs?.val == rhs?.val
}

func >= (lhs: TreeNode?, rhs: TreeNode?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else { return true }
    return lhs.val >= rhs.val
}

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

let tree = TreeNode(val: 4, left: TreeNode(val: 2, left: TreeNode(val: 1), right: TreeNode(val: 3)), right: TreeNode(val: 7, left: TreeNode(val: 6), right: TreeNode(val: 9)))
//:  翻转
func invert(head: TreeNode?) -> TreeNode? {
    guard head != nil else { return nil }
    let leftNode = head?.left
    head?.left = invert(head: head?.right)
    head?.right = invert(head: leftNode)
    return head
}
//:  前序
// 递归
func preorder(head: TreeNode?) -> [Int] {
    guard let head = head else { return [] }
    return [head.val] + preorder(head: head.left) + preorder(head: head.right)
}
// 非递归
func preorder1(head: TreeNode?) -> [Int] {
    guard head != nil else { return [] }
    var stack: [TreeNode] = []
    var result: [Int] = []
    var root = head
    while root != nil || !stack.isEmpty {
        while root != nil {
            result.append(root!.val)
            stack.append(root!)
            root = root?.left
        }
        if !stack.isEmpty {
            root = stack.removeLast()
            root = root?.right
        }
    }
    
    return result
}
let tree1 = TreeNode(val: 4, left: TreeNode(val: 2, right: TreeNode(val: 3)), right: TreeNode(val: 7, right: TreeNode(val: 9)))
let result = preorder1(head: tree)


//:  中序
// 递归
func inorder(head: TreeNode?) -> [Int] {
    guard let head = head else { return [] }
    return inorder(head: head.left) + [head.val] + inorder(head: head.right)
}

// 非递归
func inorder1(head: TreeNode?) -> [Int] {
    guard head != nil else { return [] }
    var root = head
    var stack: [TreeNode] = []
    var result: [Int] = []
    while root != nil || !stack.isEmpty {
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
    
    return result
}

let result1 = inorder(head: tree)
let result11 = inorder1(head: tree)

//:  后续遍历
// 递归
func followup(head: TreeNode?) -> [Int] {
    guard head != nil else { return [] }
    return followup(head: head?.left) + followup(head: head?.right) + [head!.val]
}
// 非递归 双栈
func followup1(head: TreeNode?) -> [Int] {
    guard head != nil else { return [] }
    var result: [Int] = []
    var stack1: [TreeNode] = []
    var stack2: [TreeNode] = []
    var root = head
    while root != nil || !stack1.isEmpty {
        while root != nil {
            stack1.append(root!)
            stack2.append(root!)
            root = root?.right
        }
        if !stack1.isEmpty {
            root = stack1.removeLast()
            root = root?.left
        }
    }
    while !stack2.isEmpty {
        root = stack2.removeLast()
        result.append(root!.val)
    }
    
    return result
}
// 非递归 单栈
func followup2(head: TreeNode?) -> [Int] {
    guard head != nil else { return [] }
    var result: [Int] = []
    var stack: [TreeNode] = [head!]
    var pre: TreeNode?
    var cur: TreeNode?
    while !stack.isEmpty {
        cur = stack.last
        if pre == nil || pre?.left == cur || pre?.right == cur {
            if cur?.left != nil {
                stack.append(cur!.left!)
            } else if cur?.right != nil {
                stack.append(cur!.right!)
            }
        } else if pre == cur?.left {
            if cur?.right != nil {
                stack.append(cur!.right!)
            }
        } else {
            stack.removeLast()
            result.append(cur!.val)
        }
        pre = cur
    }
    return result
}

let resultFP = followup(head: tree)
let resultFP1 = followup1(head: tree)
let resultFP2 = followup2(head: tree)

//:  验证二叉搜索树（1、节点的左子树只包含小于当前节点的数。2、节点的右子树只包含大于当前节点的数。3、所有左子树和右子树自身必须也是二叉搜索树。
func isValidBST(head: TreeNode?) -> Bool {
    guard head != nil else { return true }
    let result = head >= head?.left && head?.right >= head
    return result && isValidBST(head: head?.left) && isValidBST(head: head?.right)
}
let bst = TreeNode(val: 10, left: TreeNode(val: 8, left: TreeNode(val: 7), right: TreeNode(val: 9)), right: TreeNode(val: 10))
let bstResult = isValidBST(head: bst)

//: 二叉树的最近公共祖先（给定一个二叉树， 找到该树中两个指定节点的最近公共祖先）
func lowestComAncestor(head: TreeNode?, p: Int, q: Int) -> TreeNode? {
    guard head != nil else { return nil }
    if head?.val == p || head?.val == q { return head }
    let left = lowestComAncestor(head: head?.left, p: p, q: q)
    let right = lowestComAncestor(head: head?.right, p: p, q: q)
    if left == nil, right == nil { return nil }
    else if left != nil, right == nil { return left }
    else if left == nil, right != nil { return right }
    return head
}

let lowTree = TreeNode(val: 3, left: TreeNode(val: 5, left: TreeNode(val: 6), right: TreeNode(val: 2, left: TreeNode(val: 7), right: TreeNode(val: 4))), right: TreeNode(val: 1, left: TreeNode(val: 0), right: TreeNode(val: 8)))

let lowResult = lowestComAncestor(head: lowTree, p: 2, q: 4)
lowResult?.val

//: 重建二叉树（已知前序和中序)

func creat(preOrder: [Int], inOrder: [Int]) -> TreeNode? {
    guard !preOrder.isEmpty else { return nil }
    let root = preOrder[0]
    let index = findIndex(root: root, inOrder: inOrder)
    let head = TreeNode(val: root)
    let newPre: [Int] = Array(preOrder.suffix(from: 1))
    head.left = creat(preOrder: Array(newPre.prefix(index)), inOrder: Array(inOrder.prefix(index)))
    head.right = creat(preOrder: Array(newPre.suffix(from: index)), inOrder: Array(inOrder.suffix(from: index + 1)))
    return head
}

func findIndex(root: Int, inOrder: [Int]) -> Int {
    return inOrder.firstIndex(where: { root == $0 }) ?? 0
}

let head = creat(preOrder: [4, 2, 1, 3, 7, 6, 9], inOrder: [1, 2, 3, 4, 6, 7, 9])
let resultT = preorder(head: head)
let resultT1 = inorder(head: head)


//: [Next](@next)

