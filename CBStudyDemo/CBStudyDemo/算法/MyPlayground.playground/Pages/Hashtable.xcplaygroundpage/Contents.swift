//: [Previous](@previous)

import Foundation

//: 两数之和（给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。你不能重复利用这个数组中同样的元素。）
func twoSum(nums: [Int], target: Int) -> (Int, Int) {
    var dict: [Int: Int] = [:]
    for (index, num) in nums.enumerated() {
        let diff = target - num
        if let tIndex = dict[diff] {
            return (tIndex, index)
        }
        dict[num] = index
    }
    return (0, 0)
}

let tup = twoSum(nums: [2, 7, 11, 15], target: 13)

//: 三数之和(给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。)
func findIndex(nums: [Int], start: Int, end: Int, target: Int) -> Int? {
    guard !nums.isEmpty, nums.count > start, nums.count > end, end >= start else { return nil }
    guard nums[start] != target else { return start }
    guard nums[end] != target else { return end }
    let mid = (start + end) / 2
    let midValue = nums[mid]
    if midValue == target {
        return mid
    } else if target > midValue  {
        return findIndex(nums: nums, start: mid, end: end, target: target)
    } else {
        return findIndex(nums: nums, start: start, end: mid, target: target)
    }
}
func threeSum(nums: [Int]) {
    guard nums.count >= 3 else { return }
    var nums = nums.sorted(by: { $0 < $1 })
    var left: Int = 0
    var right: Int = nums.count - 1
    guard nums[left] * nums[right] < 0 else { return }
    var mid: Int = (left + right) / 2
    var result: [(Int, Int, Int)] = []
    while left < right {
        var twoSum = nums[left] + nums[right]
        if let index = findIndex(nums: nums, start: left, end: right, target: -twoSum) {
            result.append((left, right, index))
            right -= 1
        }
    }
}









//: [Next](@next)
