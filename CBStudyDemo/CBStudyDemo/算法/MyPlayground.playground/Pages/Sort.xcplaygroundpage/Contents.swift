//: [Previous](@previous)

import Foundation

func swap(i: Int, j: Int, nums: inout [Int]) {
    guard i != j else { return }
    let tmp = nums[i]
    nums[i] = nums[j]
    nums[j] = tmp
}


//: 冒泡排序
func buddleSort(nums: [Int]) {
    var nums = nums
    for i in 0..<nums.count{
        for j in 0..<(nums.count - i - 1) {
            if nums[j] < nums[j + 1] {
                swap(i: j, j: j + 1, nums: &nums)
            }
        }
    }
    nums
}
buddleSort(nums: [5, 6, 4, 7, 3, 8])

//: 选择排序：每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，然后，再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。以此类推，直到全部待排序的数据元素排完。
func selectSort(nums: [Int]) {
    var nums = nums
    for i in 0..<nums.count {
        var min = i
        for j in i..<nums.count {
            if nums[min] > nums[j] {
                min = j
            }
        }
        swap(i: i, j: min, nums: &nums)
    }
    nums
}

selectSort(nums: [5, 6, 4, 7, 3, 8])

//: 直接插入排序：每步将一个待排序的记录，按其关键码值的大小插入前面已经排序的文件中适当位置上，直到全部插入完为止.算法适用于少量数据的排序，
func insertSort(nums: [Int]) {
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
    nums
}
insertSort(nums: [5, 6, 4, 7, 3, 8])

//: 快排





//: 推排序：将待排序序列构造成一个大顶堆，此时，整个序列的最大值就是堆顶的根节点。将其与末尾元素进行交换，此时末尾就为最大值。然后将剩余n-1个元素重新构造成一个堆，这样会得到n个元素的次小值。如此反复执行，便能得到一个有序序列了
func heapSort(nums: inout [Int], count: Int) {
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
var heapArr: [Int] = [4, 6, 8, 5, 9]
heapSort(nums: &heapArr, count: 5)
heapArr





//: [Next](@next)
