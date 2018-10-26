//
//  1_TwoSum.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/17.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation
/*
 给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。
 
 你可以假设每个输入只对应一种答案，且同样的元素不能被重复利用。
 
 示例:
 
 给定 nums = [2, 7, 11, 15], target = 9
 
 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]
 */

class TwoSum {
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in (0..<nums.count-1) {
            for j in (i+1..<nums.count) {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return []
    }
    
    struct CBNum {
        let index: Int
        let value: Int
    }
    
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        var nums = nums.enumerated().map({ CBNum(index: $0, value: $1) }).sorted(by: { $0.value < $1.value })
        var left: Int = 0
        var right: Int = nums.count - 1
        while left < right {
            let leftNum = nums[left]
            let rightNum = nums[right]
            if leftNum.value + rightNum.value > target {
                right -= 1
            } else if leftNum.value + rightNum.value == target {
                return [leftNum.index, rightNum.index]
            } else {
                left += 1
            }
        }
        return []
    }
    
    func twoSum3(_ nums: [Int], _ target: Int) -> [Int] {
        var dict: [Int: Int] = [:]
        for (index, num) in nums.enumerated() {
            if let id = dict[target - num] {
                return [id, index]
            } else {
                dict[num] = index
            }
        }
        return []
    }
}
