//
//  SignalTest.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/19.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Result
import ReactiveSwift
import Foundation

class SignalTest {
    static func testAll() {
        debugExample("Subscription") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let subscriber1 = Signal<Int, NoError>.Observer(value: { print("Subscriber 1 received \($0)") })
            let subscriber2 = Signal<Int, NoError>.Observer(value: { print("Subscriber 2 received \($0)") })
            
            signal.observe(subscriber1)
            observer.send(value: 1)
            
            signal.observe(subscriber2)
            observer.send(value: 20)
        }
        
        debugExample("empty") {
            let emptySignal = Signal<Int, NoError>.empty
            let observer = Signal<Int, NoError>.Observer(value: { _ in print("value not called") }, failed: { _ in print("error not called") }, completed: { print("completed not called") }, interrupted: { print("interrupted called") })
            emptySignal.observe(observer)
        }
        debugExample("never") {
            let neverSignal = Signal<Int, NoError>.never
            let observer = Signal<Int, NoError>.Observer(value: { _ in print("value not called") }, failed: { _ in print("error not called") }, completed: { print("completed not called") }, interrupted: { print("interrupted not called") })
            neverSignal.observe(observer)
        }
        debugExample("uniqueValues") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let subscriber = Signal<Int, NoError>.Observer(value: { print("Subscriber received \($0)") })
            let uniqueSignal = signal.uniqueValues()
            uniqueSignal.observe(subscriber)
            observer.send(value: 1)
            observer.send(value: 2)
            observer.send(value: 3)
            observer.send(value: 4)
            observer.send(value: 3)
            observer.send(value: 3)
            observer.send(value: 5)
        }
        debugExample("map") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let subscriber = Signal<Int, NoError>.Observer(value: { print("Subscriber received \($0)") })
            let mappedSignal = signal.map({ $0 * 2 })
            mappedSignal.observe(subscriber)
            observer.send(value: 10)
        }
        debugExample("filter") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let subscriber = Signal<Int, NoError>.Observer(value: { print("Subscriber received \($0)") })
            let filteredSignal = signal.filter({ $0 > 12 })
            filteredSignal.observe(subscriber)
            observer.send(value: 10)
            observer.send(value: 11)
            observer.send(value: 12)
            observer.send(value: 13)
            observer.send(value: 14)
        }
        debugExample("skipNul") {
            let (signal, observer) = Signal<Int?, NoError>.pipe()
            let subscriber = Signal<Int, NoError>.Observer(value: { print("Subscriber received \($0)") })
            signal.skipNil().observe(subscriber)
            observer.send(value: 1)
            observer.send(value: nil)
            observer.send(value: 3)
        }
        debugExample("take(first)") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let subscriber = Signal<Int, NoError>.Observer(value: { print("Subscriber received \($0)") })
            signal.take(first: 2).observe(subscriber)
            observer.send(value: 1)
            observer.send(value: 2)
            observer.send(value: 3)
            observer.send(value: 4)
        }
        debugExample("collect") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let subscriber1 = Signal<[Int], NoError>.Observer(value: { print("Subscriber received \($0)") })
            signal.collect().observe(subscriber1)
            observer.send(value: 1)
            observer.send(value: 2)
            observer.send(value: 3)
            observer.send(value: 4)
            observer.sendCompleted()
        }
    }
}
















