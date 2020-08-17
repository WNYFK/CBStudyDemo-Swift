//: [Previous](@previous)
// https://www.jianshu.com/p/af880bbba792
import Foundation

//: 爬楼梯:假设你正在爬楼梯。需要 n 阶你才能到达楼顶。每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
func climbStairs(n: Int) -> Int {
    if n <= 2 { return n }
    return climbStairs(n: n - 1) + climbStairs(n: n - 2)
}

let climb1 = climbStairs(n: 2)
let climn2 = climbStairs(n: 3)

func climbStairs1(n: Int) -> Int {
    guard n > 2 else { return n }
    var min = 1
    var max = 2
    var i = 3
    while i <= n {
        let tmp = min + max
        min = max
        max = tmp
        i += 1
    }
    
    return max
}

let climb1_1 = climbStairs1(n: 2)
let climn2_1 = climbStairs1(n: 3)

func path(m: Int, n: Int) -> Int {
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

let path1 = path(m: 3, n: 2)
let path2 = path(m: 7, n: 3)

func path1(dp: [[Int]], m: Int, n: Int) -> Int {
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
let arr1: [Int] = [1, 0, 1]
let arr2: [Int] = [1, 1, 1]
let path1_1 = path1(dp: [arr1, arr2], m: 2, n: 3)


func uniquePathsWithObstacles(obstacleGrid: [[Int]]) -> Int {
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

var arr1_1: [Int] = [0, 0, 0]
var arr1_2: [Int] = [0, 1, 0]
var arr1_3: [Int] = [0, 0, 0]
var arr1_4: [Int] = [1, 0, 0]
let r = uniquePathsWithObstacles(obstacleGrid: [arr1_1, arr1_2, arr1_3, arr1_4])

func uniquePathsWithObstacles1(obstacleGrid: [[Int]]) -> Int {
    guard !obstacleGrid.isEmpty else { return 0 }
    guard !obstacleGrid[0].isEmpty else { return 0 }
    guard obstacleGrid[0][0] != 1 else { return 0 }
    let m: Int = obstacleGrid.count
    let n: Int = obstacleGrid[0].count
    var f: [Int] = Array(repeating: 0, count: n)
    f[0] = obstacleGrid[0][0] == 0 ? 1 : 0
    for i in (0..<m) {
        f[0] = (obstacleGrid[i][0] == 1) ? 0 : f[0]
        for j in (1..<n) {
            if obstacleGrid[i][j] == 1 {
                f[j] = 0
            } else {
                f[j] = f[j] + f[j - 1]
            }
        }
    }
    return f[n - 1]
}
let r1 = uniquePathsWithObstacles1(obstacleGrid: [arr1_1, arr1_2, arr1_3, arr1_4])








//: [Next](@next)
