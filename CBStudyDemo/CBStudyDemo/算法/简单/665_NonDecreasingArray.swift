//
//  665_NonDecreasingArray.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/24.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

// [3,4,2,3]
//[2,3,3,2,4]
// [4,2,3]
//[3,4,2,3]
class NonDecreasingArray {
    func checkPossibility(_ nums: [Int]) -> Bool {
        guard nums.count > 1 else { return true }
        var i = 0, j = nums.count - 1
        while i < j && nums[i] <= nums[i + 1] {
            i += 1
        }
        while i < j && nums[j] >= nums[j - 1] {
            j -= 1
        }
        if j - i <= 1 {
            let head = i != 0 ? nums[i - 1] : Int.min
            let right = j != nums.count - 1 ? nums[j + 1] : Int.max
            return nums[i] <= right || head <= nums[j]
        }
        return false
    }
    
    func checkPossibility2(_ nums: [Int]) -> Bool {
        var i = 0, length = nums.count - 1, count = 0
        var nums = nums
        while i < length && count <= 1 {
            if nums[i] > nums[i + 1] {
                if i > 0 {
                    if nums[i - 1] < nums[i + 1] {
                        nums[i] = nums[i - 1]
                    } else {
                        nums[i + 1] = nums[i]
                    }
                }
                count += 1
            }
            i += 1
        }
        return count <= 1
    }
}
