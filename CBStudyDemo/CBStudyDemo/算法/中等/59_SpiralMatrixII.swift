//
//  59_SpiralMatrixII.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/25.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

class SpiralMatrixII {
    func generateMatrix(_ n: Int) -> [[Int]] {
        var n = n
        var result = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: n), count: n)
        var i = 1
        let max = n * n
        var x = 0, y = 0
        while i <= max {
            while y < n && result[x][y] == 0 {  //向右
                result[x][y] = i
                i += 1
                y += 1
            }
            x += 1
            y -= 1
            while x < n && result[x][y] == 0 {  //向下
                result[x][y] = i
                i += 1
                x += 1
            }
            x -= 1
            y -= 1
            while y >= 0 && result[x][y] == 0 { //向左
                result[x][y] = i
                i += 1
                y -= 1
            }
            y += 1
            x -= 1
            while x >= 0 && result[x][y] == 0 { //向上
                result[x][y] = i
                i += 1
                x -= 1
            }
            x += 1
            y += 1
            n -= 1
        }
        return result
    }
}
