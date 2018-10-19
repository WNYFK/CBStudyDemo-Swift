//
//  RomanToInteger.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/16.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

class RomanToInteger {
    
    enum IntType: Character {
        case I = "I"
        case V = "V"
        case X = "X"
        case L = "L"
        case C = "C"
        case D = "D"
        case M = "M"
        
        var value: Int {
            let dict: [IntType: Int] = [.I: 1, .V: 5, .X: 10, .L: 50, .C: 100, .D: 500, .M: 1000]
            return dict[self] ?? 1
        }
        
        var canBefore: [Character] {
            switch self {
            case .I:
                return [IntType.V.rawValue, IntType.X.rawValue]
            case .X:
                return [IntType.L.rawValue, IntType.C.rawValue]
            case .C:
                return [IntType.D.rawValue, IntType.M.rawValue]
            default:
                return []
            }
        }
    }
    
    func romanToInt(_ s: String) -> Int {
        guard s.count > 1 else { return IntType(rawValue: Character(s))?.value ?? 0 }
        var result: Int = 0
        var lastValue: IntType?
        s.forEach {value in
            let tp = IntType(rawValue: value)!
            if let lastVT = lastValue, lastVT.canBefore.contains(value) {
                result += tp.value - lastVT.value * 2
            } else {
                result += tp.value
            }
            lastValue = tp
        }
        return result
    }
}
