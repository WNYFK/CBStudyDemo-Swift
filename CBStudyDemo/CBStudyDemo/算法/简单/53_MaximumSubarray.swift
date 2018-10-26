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
        func solve(_ left: Int, right: Int) -> Int {
            if left == right {
                return nums[left]
            }
            let mid = (left + right) / 2
            let lans = solve(left, right: mid)
            let rans = solve(mid + 1, right: right)
            var sum = 0
            var lmax = nums[mid]
            var rmax = nums[mid + 1]
            for i in (left...mid).reversed() {
                sum += nums[i]
                if sum > lmax {
                    lmax = sum
                }
            }
            sum = 0
            for i in (mid+1...right) {
                sum += nums[i]
                if sum > rmax {
                    rmax = sum
                }
            }
            var ans = lmax + rmax
            if ans < lans {
                ans = lans
            }
            if ans < rans {
                ans = rans
            }
            return ans
        }
        return solve(0, right: nums.count - 1)
    }
    
    func maxSubArray3(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var sum = 0
        var maxSum = Int.min
        for i in (0..<nums.count) {
            sum += nums[i]
            maxSum = max(sum, maxSum)
            if sum < 0 {
                sum = 0
            }
        }
        return maxSum
    }
}






