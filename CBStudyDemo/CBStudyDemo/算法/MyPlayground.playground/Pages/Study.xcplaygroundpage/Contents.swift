//: [Previous](@previous)

import Foundation

func run(_ des: String, callback: (() -> Void)) {
    print(des)
    callback()
}

protocol HTNState {
    associatedtype StateType
    func add(_ item: StateType)
}

struct States: HTNState {
    typealias StateType = Int
    func add(_ item: StateType) {
        
    }
}

struct States1<T>: HTNState {
    typealias StateType = T
    func add(_ item: StateType) {
        
    }
}

struct DragonFirePosition {
    var x: Int32?            // 8
    var y: Int64            // 4
}
protocol DragonFire {}
struct YellowDragon: DragonFire {
    let eyes: String
    let teeth: Int64
}

run("内存分配") {
    MemoryLayout<DragonFirePosition>.size
    MemoryLayout<DragonFirePosition>.alignment
    MemoryLayout<DragonFirePosition>.stride
    MemoryLayout<DragonFire>.size
    MemoryLayout<YellowDragon>.size
}


//:  指针使用
run("指针使用") {
    let a = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    a.pointee = 10
    
    var f: Int = 1
    var fPointer = withUnsafePointer(to: &f, { $0 })
    fPointer.pointee
    
    let aptr = UnsafeMutablePointer<Int>.allocate(capacity: 5)
    aptr.initialize(from: [33, 34, 35, 36, 37], count: 5)
    aptr.pointee
    aptr.advanced(by: 1).pointee
    aptr.advanced(by: 1).successor().pointee
    (aptr.advanced(by: 1) + 2).pointee
    UnsafeRawPointer(aptr.advanced(by: 1)).bindMemory(to: Int.self, capacity: 1).pointee
}








//: [Next](@next)
