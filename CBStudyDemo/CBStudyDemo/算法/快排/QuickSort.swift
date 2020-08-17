//
//  QuickSort.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/18.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct CBQuickSort {
    func quicksort(start: Int, end: Int, array: inout [Int]) -> Int {
        guard start != end, start >= 0, end > 0 else { return -1 }
        guard array.count > end else { return -1 }
        let example = array[start]
        var p = start
        for i in (start+1)..<end {
            if array[i] < example {
                p += 1
                swap(i: i, j: p, array: &array)
            }
        }
        swap(i: p, j: start, array: &array)
        return p;
    }

    func swap(i: Int, j: Int, array: inout [Int]) {
      let tmp = array[i]
      array[i] = array[j]
      array[j] = tmp
    }

    func quicksortMain(start: Int, end: Int, array: inout [Int]) {
        guard start >= 0, end >= 0, start != end else { return }
        let mid = quicksort(start: start, end: end, array: &array)
        if mid > start {
            quicksortMain(start: start, end: mid, array: &array)
        }
        if mid < end {
            quicksortMain(start: mid + 1, end: end, array: &array)
        }
    }
    
    static func example() {
        var array: [Int] = [5, 1, 4, 3, 2, 7, 6, 8]
        let obj = CBQuickSort()
        obj.quicksortMain(start: 0, end: array.count - 1, array: &array)
        print(array)
    }
}

