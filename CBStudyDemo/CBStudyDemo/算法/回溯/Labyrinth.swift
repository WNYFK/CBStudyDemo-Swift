//
//  Labyrinth.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/26.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation

// 迷宫

class Labyrinth {
    func allPath1(_ maze: [[Int]], start: (Int, Int), end: (Int, Int)) {
        let placeholder = -1
        var maze = maze
        var curPosition = start
        var result: [[(Int, Int)]] = []
        var tmp: [(Int, Int)] = []
        let n = maze.count
        //
        func solve(_ position: (Int, Int), isMaze: Bool, dir: Int) -> Bool {
            if !isMaze {
                if position != end {
                    maze[position.0][position.1] = placeholder
                    tmp.append(position)
                } else {
                    result.append(tmp)
                    return solve(tmp.last!, isMaze: true, dir: dir + 1 <= 4 ? dir + 1 : 0)
                }
            } else if dir == 0 {
                maze[position.0][position.1] = 1
                tmp.removeLast()
                if let lastPosition = tmp.last {
                    return solve(lastPosition, isMaze: true, dir: dir + 1 > 4 ? 0 : dir + 1)
                }
            }
            if position.1 + 1 < n && maze[position.0][position.1 + 1] == 1 && (!isMaze || isMaze && dir == 1) { //向右
                return solve((position.0, position.1 + 1), isMaze: false, dir: 1)
            } else if position.0 + 1 < n && maze[position.0 + 1][position.1] == 1 && (!isMaze || isMaze && dir == 2) {    //向下
                return solve((position.0 + 1, position.1), isMaze: false, dir: 2)
            } else if position.1 - 1 >= 0 && maze[position.0][position.1 - 1] == 1 && (!isMaze || isMaze && dir == 3) {    // 向左
                return solve((position.0, position.1 - 1), isMaze: false, dir: 3)
            } else if position.0 - 1 >= 0 && maze[position.0 - 1][position.1] == 1 && (!isMaze || isMaze && dir == 4) {    // 向上
                return solve((position.0 - 1, position.1), isMaze: false, dir: 4)
            } else {
                maze[position.0][position.1] = 1
                tmp.removeLast()
                if let lastPosition = tmp.last {
                    return solve(lastPosition, isMaze: true, dir: dir + 1 > 4 ? 0 : dir + 1)
                }
            }
            return false
        }
        let _ = solve(curPosition, isMaze: false, dir: 1)
        print(result)
    }
    
    func allPath(_ maze: [[Int]], start: (Int, Int), end: (Int, Int)) {
        let placeholder = -1
        var maze = maze
        var curPosition = start
        var result: [[(Int, Int)]] = []
        var tmp: [(Int, Int)] = []
        let n = maze.count
        //
        func solve(_ position: (Int, Int), isMaze: Bool, dir: Int) {
            if !isMaze {
                if position != end {
                    maze[position.0][position.1] = placeholder
                    tmp.append(position)
                } else {
                    result.append(tmp)
                    return solve(tmp.last!, isMaze: true, dir: dir + 1 <= 4 ? dir + 1 : 0)
                }
            } else if dir == 0 {
                maze[position.0][position.1] = 1
                tmp.removeLast()
                if let lastPosition = tmp.last {
                    return solve(lastPosition, isMaze: true, dir: dir + 1 > 4 ? 0 : dir + 1)
                }
            }
            if position.1 + 1 < n && maze[position.0][position.1 + 1] == 1 && (!isMaze || isMaze && dir == 1) { //向右
                solve((position.0, position.1 + 1), isMaze: false, dir: 1)
            } else if position.0 + 1 < n && maze[position.0 + 1][position.1] == 1 && (!isMaze || isMaze && dir == 2) {    //向下
                solve((position.0 + 1, position.1), isMaze: false, dir: 2)
            } else if position.1 - 1 >= 0 && maze[position.0][position.1 - 1] == 1 && (!isMaze || isMaze && dir == 3) {    // 向左
                solve((position.0, position.1 - 1), isMaze: false, dir: 3)
            } else if position.0 - 1 >= 0 && maze[position.0 - 1][position.1] == 1 && (!isMaze || isMaze && dir == 4) {    // 向上
                solve((position.0 - 1, position.1), isMaze: false, dir: 4)
            } else {
                maze[position.0][position.1] = 1
                tmp.removeLast()
                if let lastPosition = tmp.last {
                    return solve(lastPosition, isMaze: true, dir: dir + 1 > 4 ? 0 : dir + 1)
                }
            }
        }
        solve(curPosition, isMaze: false, dir: 1)
        print(result)
    }
}
