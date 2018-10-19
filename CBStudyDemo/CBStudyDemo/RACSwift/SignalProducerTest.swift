//
//  SignalProducer.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/18.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

class SignalProducerTest {
    static func testAll() {
        debugExample("Subscription") {
            let producer = SignalProducer<Int, NoError>({ (observer, _) in
                print("New subscription, starting operation")
                observer.send(value: 1)
                observer.send(value: 2)
                observer.sendCompleted()
            })
            
            let subscriber1 = Signal<Int, NoError>.Observer(value: { print("Subscriber 1 received \($0)") })
            let subscriber2 = Signal<Int, NoError>.Observer(value: { print("Subscriber 2 received \($0)") })
            producer.start(subscriber1)
            producer.start(subscriber2)
            producer.start({ (event) in
                print("event \(event.value ?? 0)  \(event.isCompleted)")
            })
        }
        
        debugExample("empty") {
            let emptyProducer = SignalProducer<Int, NoError>.empty
            let observer = Signal<Int, NoError>.Observer(value: { _ in print("value no called") }, failed: { _ in print("error not called") }, completed: { print("completerd called") })
            emptyProducer.start(observer)
            emptyProducer.start({ (event) in
                print("event \(event.isCompleted)")
            })
        }
        
        debugExample("never") {
            let neverProducer = SignalProducer<Int, NoError>.never
            let observer = Signal<Int, NoError>.Observer(value: { _ in print("value no called") }, failed: { _ in print("error not called") }, completed: { print("completerd called") })
            neverProducer.start(observer)
            neverProducer.start({ (event) in
                print("event \(event.isCompleted)")
            })
        }
        
        debugExample("startWithSignal") {
            var value: Int?
            SignalProducer<Int, NoError>(value: 42)
                .on(value: {
                    value = $0
                })
                .startWithSignal({ (signal, disposable) -> Result<Bool, NoError> in
                print("-----\(value)")
                return .success(true)
            })
            print(value)
        }
        
        debugExample("startWithResult") {
            SignalProducer<Int, NoError>(value: 42).startWithResult({ (result) in
                print(result.value)
            })
        }
        debugExample("startWithValue") {
            SignalProducer<Int, NoError>(value: 42).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("startWithCompleted") {
            SignalProducer<Int, NoError>(value: 42).startWithCompleted({
                print("completed")
            })
        }
        debugExample("startWithFailed") {
            SignalProducer<Int, NSError>(value: 42).startWithFailed({ (error) in
                print(error)
            })
            SignalProducer<Int, NSError>(error: NSError(domain: "example", code: 42, userInfo: nil)).startWithFailed({ (error) in
                print(error)
            })
        }
        debugExample("startWithInterrupted") {
            let disposable = SignalProducer<Int, NoError>.never.startWithInterrupted({
                print("interrupted called")
            })
            print("disposable")
            disposable.dispose()
        }
        debugExample("lift") {
            SignalProducer<Int, NoError>(value: 10).lift({ (signal) -> Signal<Int, NoError> in
                return signal.map({ (value) -> Int in
                    return value > 0 ? value : 42
                })
            }).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("map") {
            SignalProducer<Int, NoError>(value: 1).map({ $0 + 21 }).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("filter") {
            SignalProducer<Int, NoError>([1, 2, 3, 4, 5, 6]).filter({ $0 > 3 }).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("take(first:)") {
            SignalProducer<Int, NoError>([1, 2, 3, 4, 5, 6]).take(first: 2).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("collect") {
            SignalProducer<Int, NoError>({ (observer, disposable) in
                observer.send(value: 1)
                observer.send(value: 2)
                observer.send(value: 3)
                observer.send(value: 4)
                observer.sendCompleted()
            }).collect().startWithValues({ (values) in
                print(values)
            })
        }
        debugExample("collect(count:)") {
            SignalProducer<Int, NoError>({ (observer, disposable) in
                observer.send(value: 1)
                observer.send(value: 2)
                observer.send(value: 3)
                observer.send(value: 4)
                observer.send(value: 5)
                observer.sendCompleted()
            }).collect(count: 2).startWithValues({ (values) in
                print(values)
            })
        }
        debugExample("collect(_:) matching values inclusively") {
            SignalProducer<Int, NoError>({ (observer, disposable) in
                observer.send(value: 1)
                observer.send(value: 2)
                observer.send(value: 3)
                observer.send(value: 4)
                observer.sendCompleted()
            }).collect({ (values) -> Bool in
                return values.reduce(0, +) == 3
            }).startWithValues({ (values) in
                print(values)
            })
        }
        debugExample("combineLatest(with:)") {
            let producer1 = SignalProducer<Int, NoError>([1, 2, 3, 4, 5])
            let producer2 = SignalProducer<Int, NoError>([1, 2])
            producer1.combineLatest(with: producer2).startWithValues({ (value) in
                print(value)
            })
            producer2.combineLatest(with: producer1).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("skip(first)") {
            SignalProducer<Int, NoError>([1, 2, 3, 4]).skip(first: 2).collect().startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("materialize") {
            SignalProducer<Int, NoError>([1, 2, 3, 4, 5]).materialize().startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("sample(on:)") {
            let baseProducer = SignalProducer<Int, NoError>([1, 2, 3, 4, 5])
            let sampledOnProducer = SignalProducer<Int, NoError>([1, 2, 3]).map({ _ in () })
            
            baseProducer.sample(on: sampledOnProducer).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("combinePrevious") {
            SignalProducer<Int, NoError>([1, 2, 3, 4]).combinePrevious(42).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("scan") {
            SignalProducer<Int, NoError>([1, 2, 3, 4]).scan(0, +).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("reduce") {
            SignalProducer<Int, NoError>([1, 2, 3, 4]).reduce(0, +).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("skipRepeats") {
            SignalProducer<Int, NoError>([1, 1, 1, 2, 2, 2, 2, 3, 3, 4, 5, 6]).skipRepeats(==).startWithValues({ (value) in
                print(value)
            })
        }
        /// 注
        debugExample("skip(while:)") {
            SignalProducer<Int, NoError>([3, 3, 3, 3, 1, 2, 4, 4, 5]).skip(while: { $0 > 2 }).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("take(untilReplacement:)") {
            let (replacementSignal, incomingReplacementObserver) = Signal<Int, NoError>.pipe()
            let baseProducer = SignalProducer<Int, NoError>({ (observer, _) in
                observer.send(value: 1)
                observer.send(value: 2)
                observer.send(value: 3)
                incomingReplacementObserver.send(value: 42)
                observer.send(value: 4)
                incomingReplacementObserver.send(value: 43)
            })
            baseProducer.take(untilReplacement: replacementSignal).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("take(last:)") {
            SignalProducer<Int, NoError>([1, 2, 3, 4]).take(last: 2).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("skipNil") {
            SignalProducer<Int?, NoError>([nil, 1, 2, nil, 3, 4, nil]).skipNil().startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("zip(with)") {
            let baseProducer = SignalProducer<Int, NoError>([1, 2, 3, 4])
            let zippedProducer = SignalProducer<Int, NoError>([42, 43])
            baseProducer.zip(with: zippedProducer).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("repeat") {
            var counter = 0
            SignalProducer<(), NoError>({ (observer, _) in
                counter += 1
                observer.sendCompleted()
            }).repeat(42).start()
            print(counter)
        }
        debugExample("retry(upTo:)") {
            var tries = 0
            SignalProducer<Int, NSError>({ (observer, _) in
                print("aaaa")
                if tries < 2 {
                    tries += 1
                    observer.send(error: NSError(domain: "retry", code: 0, userInfo: nil))
                } else {
                    observer.send(value: 42)
                    observer.sendCompleted()
                }
            }).retry(upTo: 2).startWithResult({ (result) in
                print(result)
            })
        }
        debugExample("then") {
            let baseProducer = SignalProducer<Int, NoError>([1, 2, 3, 4])
            let thenProducer = SignalProducer<Int, NoError>([41, 15])
            baseProducer.then(thenProducer).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("replayLazily") {
            let baseProducer = SignalProducer<Int, NoError>([1, 2, 3, 4, 5]).replayLazily(upTo: 3)
            baseProducer.startWithValues({ (value) in
                print("value1: \(value)")
            })
            baseProducer.startWithValues({ (value) in
                print("value2: \(value)")
            })
            baseProducer.startWithValues({ (value) in
                print("value3: \(value)")
            })
        }
        debugExample("flatMap(.latest)") {
            SignalProducer<Int, NoError>([1, 2, 3, 4]).flatMap(.latest, { SignalProducer(value: $0 + 3) }).startWithValues({ (value) in
                print(value)
            })
        }
        debugExample("sample(with:)", {
            let producer = SignalProducer<Int, NoError>([1, 2, 3, 4])
            let sampler = SignalProducer<String, NoError>(["a", "b"])
            producer.sample(with: sampler).startWithValues({ (left, right) in
                print("\(left) \(right)")
            })
        })
    }
}




























