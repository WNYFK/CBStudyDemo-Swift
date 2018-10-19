//
//  53_MaximumSubarray.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/17.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/maximum-subarray/description/

// -2, 1, -3, 4, -1, 2, 1, -5, 4

class MaximumSubarray {
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return nums.first ?? 0 }
        var sum = nums[0]
        for i in 0..<nums.count {
            for j in i..<nums.count {
                var s = 0
                for k in i...j {
                    s += nums[k]
                }
                if sum < s {
                    sum = s
                }
            }
        }
        return sum
    }
    
    func maxSubArray2(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return nums.first ?? 0 }
        var sum = nums[0]
        for i in 0..<nums.count {
            for j in i..<nums.count {
                var s = 0
                for k in i...j {
                    s += nums[k]
                }
                if sum < s {
                    sum = s
                }
            }
        }
        return sum
    }
    
    func solve(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return nums.first ?? 0 }
        var left = 0
        var right = nums.count - 1
        
        return 0
    }
}






