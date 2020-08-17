//: [Previous](@previous)

import Foundation
//: https://www.jianshu.com/p/1e1a9a81bbc0
//: 在柠檬水摊上，每一杯柠檬水的售价为 5 美元。顾客排队购买你的产品，（按账单 bills 支付的顺序）一次购买一杯。
func lemonadeChange(bills: [Int]) -> Bool {
    var five: Int = 0
    var ten: Int = 0
    for bill in bills {
        if bill == 5 {
            five += 1
        } else if bill == 10 {
            five -= 1
            ten += 1
            if five < 0 {
                return false
            }
        } else if bill == 20 {
            if ten > 0 {
                ten -= 1
                five -= 1
                if five < 0 {
                    return false
                }
            } else {
                five -= 3
                if five < 0 {
                    return false
                }
            }
        } else {
            fatalError()
        }
    }
    return true
}
let r = lemonadeChange(bills: [5,5,5,10,20])
let r1 = lemonadeChange(bills: [5,5,10])
let r2 = lemonadeChange(bills: [10,10])
let r3 = lemonadeChange(bills: [5,5,10,10,20])










//: [Next](@next)
