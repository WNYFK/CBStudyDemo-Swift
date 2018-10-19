//
//  9_PalindromeNumber.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/17.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

class PalindromeNumber {
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        var tmp = x
        var result: Int = 0
        while tmp > 0 {
            result = result * 10 + tmp % 10
            tmp = tmp / 10
        }
        return result == x
    }
}
