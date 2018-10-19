//
//  26_RemoveDuplicatesfromSortedArray.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/17.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation
// https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/description/

class RemoveDuplicatesfromSortedArray {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else { return nums.count }
        var index: Int = 0
        while index < nums.count - 1 {
            if nums[index] == nums[index + 1] {
                nums.remove(at: index + 1)
            } else {
                index += 1
            }
        }
        return nums.count
    }
    
    func removeDuplicates2(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        var index: Int = 0
        for i in (1..<nums.count) {
            if nums[index] != nums[i] {
                index += 1
                nums[index] = nums[i]
            }
        }
        nums.removeSubrange(index+1..<nums.count)
        return index + 1
    }
}
