//
//  DynamicProgramming.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/6/2.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation

struct DynamicProgramming {
    static func path(m: Int, n: Int) -> Int {
        var dp: [[Int]] = Array(repeating: Array(repeating: 1, count: 101), count: 101)
        var i = 1
        var j = 1
        while i < m {
            while j < n {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
                j += 1
            }
            i += 1
            j = 1
        }
        return dp[m - 1][n - 1]
    }
    
    static func path1(dp: [[Int]], m: Int, n: Int) -> Int {
        var dp = dp
        var i = 1
        var j = 1
        while i < m {
            while j < n {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
                j += 1
            }
            i += 1
            j = 1
        }
        return dp[m - 1][n - 1]
    }
    
    static func uniquePathsWithObstacles(obstacleGrid: [[Int]]) -> Int {
        guard !obstacleGrid.isEmpty else { return 0 }
        guard obstacleGrid[0][0] != 1 else { return 0 }
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        var paths: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        paths[0][0] = 1
        for i in (1..<m) {
            if obstacleGrid[i][0] != 1 {
                paths[i][0] = paths[i - 1][0]
            }
        }
        for i in (1..<n) {
            if obstacleGrid[0][i] != 1 {
                paths[0][i] = paths[0][i - 1]
            }
        }
        for i in (1..<m) {
            for j in (1..<n) {
                if obstacleGrid[i][j] != 1 {
                    paths[i][j] = paths[i - 1][j] + paths[i][j - 1]
                }
            }
        }
        return paths[m - 1][n - 1]
    }
    
    static func test() {
//        let path1 = DynamicProgramming.path(m: 3, n: 2)
//        let arr1: [Int] = [1, 0, 1]
//        let arr2: [Int] = [1, 1, 1]
//        let path1_1 = DynamicProgramming.path1(dp: [arr1, arr2], m: 2, n: 3)
        
        let arr1_1: [Int] = [0, 0, 0]
        let arr1_2: [Int] = [0, 1, 0]
        let arr1_3: [Int] = [0, 0, 0]
        var arr1_4: [Int] = [1, 0, 0]
        let r = DynamicProgramming.uniquePathsWithObstacles(obstacleGrid: [arr1_1, arr1_2, arr1_3, arr1_4])

    }
}
