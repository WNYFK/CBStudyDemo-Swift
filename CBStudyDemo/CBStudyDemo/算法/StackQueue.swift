//
//  StackQueue.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/5/28.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct StackQueue {
    
//: 有效的括号(给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。)
    func isValid(str: String) -> Bool {
        guard !str.isEmpty else { return true }
        var stack: [String] = []
        let dict: [String: String] = ["(": ")", "[": "]", "{": "}"]
        for s in str {
            if let value = dict[s.description] {
                stack.append(value)
            } else if stack.last == s.description {
                stack.removeLast()
            } else {
                return false
            }
        }
        return stack.isEmpty
    }
    
    func decodeString(str: String) -> String {
        guard !str.isEmpty else { return "" }
        var stack: [String] = []
        var result: String = ""
        for s in str {
            if s == "]" {
                result += configString(stack: &stack)
            } else {
                stack.append(s.description)
            }
        }
        return result + configString(stack: &stack)
    }

    func configString(stack: inout [String]) -> String {
        guard !stack.isEmpty else { return "" }
        let str = popNearest(stack: &stack, str: "[")
        let count = popNearestNum(stack: &stack)
        return configString(stack: &stack) + repeatString(count: count, str: str)
    }

    func repeatString(count: Int, str: String) -> String {
        guard count > 1 else { return str }
        return repeatString(count: count - 1, str: str) + str
    }

    func popNearest(stack: inout [String], str: String) -> String {
        guard !stack.isEmpty else { return "" }
        var result: String = ""
        while !stack.isEmpty {
            let tmp = stack.removeLast()
            if tmp == str {
                break
            } else {
                result = tmp + result
            }
        }
        return result
    }
    
    func popNearestNum(stack: inout [String]) -> Int {
        guard !stack.isEmpty else { return 1 }
        var result: String = ""
        while !stack.isEmpty {
            let tmp = stack.last ?? ""
            let k = Int(tmp) ?? -1
            if k >= 0, k < 10 {
                stack.removeLast()
                result = tmp + result
            } else {
                break
            }
        }
        return Int(result) ?? 1
    }
    
    static func test() {
        let obj = StackQueue()
        let decodeR1 = obj.decodeString(str: "3[a2[c]]")
        print(decodeR1)
    }
}
