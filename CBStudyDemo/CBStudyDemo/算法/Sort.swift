//
//  Sort.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/29.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

func swap(i: Int, j: Int, nums: inout [Int]) {
    guard i != j else { return }
    let tmp = nums[i]
    nums[i] = nums[j]
    nums[j] = tmp
}

func maxIndex(index1: Int, index2: Int, index3: Int?, nums: [Int]) -> Int {
    if nums[index1] > nums[index2] {
        if let index3 = index3 {
            if nums[index1] > nums[index3] {
                return index1
            } else {
                return index3
            }
        }
    } else if let index3 = index3 {
        if nums[index1] < nums[index3] {
            return nums[index3] > nums[index2] ? index3 : (nums[index2] > nums[index1] ? index2 : index1)
        } else {
            return index1
        }
    }
    return index2
}

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

struct Sort {
    
    static func insertSort(nums: [Int]) {
        guard nums.count > 1 else { return }
        var nums = nums
        for i in 1..<nums.count {
            guard nums[i] < nums[i - 1] else { continue }
            let tmp = nums[i]
            var index: Int = 0
            for j in (1...i).reversed() {
                if nums[j - 1] > tmp {
                    nums[j] = nums[j - 1]
                } else {
                    index = j
                    break
                }
            }
            nums[index] = tmp
        }
        print(nums)
    }
    
    static func heapSort(nums: inout [Int], count: Int) {
          guard count > 1, nums.count >= count else { return }
          var i = count / 2 - 1
          while i >= 0 {
              let tmp = nums[i]
              let max = maxIndex(index1: i, index2: 2 * i + 1, index3: 2 * i + 2 < count ? 2 * i + 2 : nil, nums: nums)
              if i != max {
                  nums[i] = nums[max]
                  nums[max] = tmp
              }
              i -= 1
          }
          swap(i: 0, j: count - 1, nums: &nums)
          heapSort(nums: &nums, count: count - 1)
    }
    
    static func sortAges(_ nums: inout [Int]) {
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
    
    static func minRotate(nums: [Int], start: Int, end: Int) -> Int? {
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
    
    static func test() {
//        Sort.insertSort(nums: [5, 6, 4, 7, 3, 8])
//        var heapArr: [Int] = [4, 6, 8, 5, 9]
//        Sort.heapSort(nums: &heapArr, count: heapArr.count)
        
//        var ages: [Int] = [23, 45, 66, 23, 34, 45, 45, 67, 68, 67]
//        Sort.sortAges(&ages)
        
        let ratateNums: [Int] = [2, 2, 2, 3, 1, 2]
        let minResult = Sort.minRotate(nums: ratateNums, start: 0, end: ratateNums.count - 1)
    }
}
