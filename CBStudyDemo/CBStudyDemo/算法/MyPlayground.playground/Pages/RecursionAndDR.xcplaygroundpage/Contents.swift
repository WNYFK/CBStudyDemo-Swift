//: [Previous](@previous)

import Foundation

//: 实现 pow(x, n) ，即计算 x 的 n 次幂函数。
func myPow(x: Double, n: Int) -> Double {
    if n == 0 || x == 1 {
        return 1
    }
    if n < 0 {
        return 1 / myPow(x: x, n: -n)
    }
    if n % 2 != 0 {
        return x * myPow(x: x, n: n - 1)
    }
    return myPow(x: x * x, n: n / 2)
}

let pow1 = myPow(x: 2, n: 2)
let pow2 = myPow(x: 2, n: 3)


//: 求众数（给定一个大小为 n 的数组，找到其中的众数。众数是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。）

func majorityElement(nums: [Int]) {
    var dict: [Int: Int] = [:]
    for num in nums {
        if var count = dict[num] {
            count = count + 1
            if count > nums.count / 2 {
                 print("众数:\(num)")
                break
            }
            dict[num] = count
        } else {
            dict[num] = 1
        }
    }
}
majorityElement(nums: [3, 2, 3])
majorityElement(nums: [2, 2, 1, 1, 1, 2, 2])

func majorityElement1(nums: [Int]) {
    guard !nums.isEmpty else { return }
    var count: Int = 1
    var ref: Int = nums[0]
    for num in nums {
        if num == ref {
            count += 1
        } else {
            count -= 1
            if count == 0 {
                ref = num
                count = 1
            }
        }
    }
    print(ref)
}
majorityElement1(nums: [3, 2, 3])
majorityElement1(nums: [2, 2, 1, 1, 1, 2, 2])


//: [Next](@next)
