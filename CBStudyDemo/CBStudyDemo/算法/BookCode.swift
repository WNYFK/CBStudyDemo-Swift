//
//  BookCode.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/6/4.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct BookCode {
    static func isFlowup(nums: [Int], start: Int, end: Int) -> Bool {
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
    
    static func isSubTree(head1: TreeNode?, head2: TreeNode?) -> Bool {
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
    static func containTree2(head1: TreeNode?, head2: TreeNode?) -> Bool {
        guard let head2 = head2 else { return true }
        guard let head1 = head1 else { return false }
        guard head1.val == head2.val else { return false }
        return containTree2(head1: head1.left, head2: head2.left) && containTree2(head1: head1.right, head2: head2.right)
    }
    
    static func test() {
//        let rr11 = isFlowup(nums: [5, 7, 6, 9, 11, 10, 8], start: 0, end: 6)
        //        let tree1 = TreeNode(val: 1, left: TreeNode(val: 2, left: TreeNode(val: 4), right: TreeNode(val: 5)), right: TreeNode(val: 6))
//        let subTree1 = TreeNode(val: 2, left: TreeNode(val: 5), right: nil)
//        let treeResult = isSubTree(head1: tree1, head2: subTree1)
//
//        var halfNums: [Int] = [1, 1, 2, 2, 2, 2, 3, 5, 2]
//        BookCode.moreHalf(nums: &halfNums)
        
        var minNums: [Int] = [5, 4, 3, 6, 7, 2, 1, 9]
        let minR = BookCode.minNums(nums: &minNums, k: 2)
    }
}


extension BookCode {
    static func partition(nums: inout [Int], start: Int, end: Int) -> Int {
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
    
    static func moreHalf(nums: inout [Int]) {
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
}

extension BookCode {
    static func minNums(nums: inout [Int], k: Int) -> [Int] {
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
}
