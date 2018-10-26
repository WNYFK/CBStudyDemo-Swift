//
//  ValidParentheses.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/16.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

class ValidParentheses {
    
    func isCouple(lC: Character, rC: Character) -> Bool {
        switch lC {
        case "(":
            return rC == ")"
        case "[":
            return rC == "]"
        case "{":
            return rC == "}"
        default:
            return false
        }
    }
    
    func isValid(_ s: String) -> Bool {
        if s.count == 0 { return true }
        if s.count == 2 {
            return isCouple(lC: s[s.startIndex], rC: s[s.index(after: s.startIndex)])
        }
        guard s.count % 2 == 0 else { return false }
        guard let index = segmentation(s) else { return false }
        let leftStr = String(s[s.startIndex...index])
        let rightStr = String(s.suffix(from: s.index(after: index)))
        if leftStr == s {
            return isValid(String(s[s.index(after: s.startIndex)...s.index(s.endIndex, offsetBy: -2)]))
        }
        return isValid(leftStr) && isValid(rightStr)
    }
    
    func segmentation(_ s: String) -> String.Index? {
        let left = s[s.startIndex]
        var leftIndex = s.index(after: s.startIndex)
        var count: Int = 1
        while leftIndex < s.endIndex {
            if left == s[leftIndex] {
                count += 1
            } else if isCouple(lC: left, rC: s[leftIndex]) {
                count -= 1
            }
            if count == 0 {
                return leftIndex
            }
            leftIndex = s.index(after: leftIndex)
        }
        return nil
    }
    
    func isValid2(_ s: String) -> Bool {
        guard s.count > 0 else { return true }
        guard s.count % 2 == 0 else { return false }
        var stackArr: [Character] = []
        var startIndex = s.startIndex
        while startIndex < s.endIndex {
            let ch = s[startIndex]
            if let last = stackArr.last, isCouple(lC: last, rC: ch) {
                stackArr.removeLast()
            } else {
                stackArr.append(ch)
            }
            startIndex = s.index(startIndex, offsetBy: 1)
        }
        return stackArr.isEmpty
    }
}







