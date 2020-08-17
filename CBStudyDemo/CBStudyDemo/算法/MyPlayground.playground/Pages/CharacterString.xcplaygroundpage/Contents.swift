//: [Previous](@previous)

import Foundation

//: 反转字符串
func reverseString(str: String) -> String {
    guard str.count > 1 else { return str }
    return reverseString(str: String(str.suffix(from: str.index(after: str.startIndex)))) + str.prefix(1)
}
let re1 = reverseString(str: "abcse")

//: 无重复字符的最长子串
func maxSubCharLength(str: String) -> Int {
    guard str.count > 1 else { return str.count }
    var maxLength: Int = 1
    var arr: [Character] = []
    for string in str {
        if arr.contains(string) {
            maxLength = max(maxLength, arr.count)
            while !arr.isEmpty {
                let char = arr.removeFirst()
                if char == string {
                    break
                }
            }
        }
        arr.append(string)
    }
    
    return maxLength
}

maxSubCharLength(str: "abcabcbb")
maxSubCharLength(str: "bbbbbb")
maxSubCharLength(str: "pwwkew")



//: [Next](@next)
