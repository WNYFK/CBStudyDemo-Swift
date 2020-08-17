//: [Previous](@previous)

import Foundation

//: 用两个栈实现队列(完成在队列尾部插入结点和在队列头部删除结点功能)
struct Queue<T> {
    private var stack1: [T] = []
    private var stack2: [T] = []
    
    var all: [T] {
        return stack2.reversed() + stack1
    }
    
    mutating func appendTail(item: T) {
        stack1.append(item)
        print(all)
    }
    
    mutating func deleteHead() -> T {
        defer {
            print(all)
        }
        if stack2.isEmpty {
            while !stack1.isEmpty {
                let item = stack1.removeLast()
                stack2.append(item)
            }
        }
        return stack2.removeLast()
    }
}

var queue = Queue<Int>()
queue.appendTail(item: 1)
queue.appendTail(item: 2)
queue.appendTail(item: 3)
queue.deleteHead()
queue.appendTail(item: 5)
queue.deleteHead()

var queue2 = Queue<String>()
queue2.appendTail(item: "a")
queue2.appendTail(item: "b")
queue2.appendTail(item: "c")
queue2.deleteHead()
queue2.appendTail(item: "a")




//: [Next](@next)
