//
//  RX.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/19.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation
import RxSwift

func delay(_ delay: Double, closure: @escaping () -> Void) {

    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
struct RXDemo {
    static func test() {
        RXCombination.startWithTest()
        RXCombination.mergeTest()
        RXCombination.zipTest()
        RXCombination.combineLatestTest()
        RXCombination.ArrayCombineLatestTest()
        RXCombination.SwitchLatestTest()
        RXCombination.MapTest()
        RXCombination.flatMapAndFlatMapLatestTest()
        RXCombination.scanTest()
        RXCombination.filterTest()
        RXCombination.distinctUntilChangedTest()
        RXCombination.elementAtTest()
        RXCombination.singleTest()
        RXCombination.singleWithConditionsTest()
        RXCombination.takeTest()
        RXCombination.takeLastTest()
        RXCombination.takeWhileTest()
        RXCombination.takeUntilTest()
        RXCombination.skipTest()
        RXCombination.skipWhileTest()
        RXCombination.skipWhileIndexTest()
        RXCombination.skipUntilTest()
        RXCombination.toArrayTest()
        RXCombination.reduceTest()
        RXCombination.concatTest()
//        RXConnectable.sampleWithoutConnectableOperators()
//        RXConnectable.sampleWithPublish()
        RXConnectable.sampleWithReplayBuffer()
    }
}

struct RXConnectable {
    static func sampleWithReplayBuffer() {
        print("sample with replay")
        let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(5)
        _ = intSequence
            .subscribe(onNext: { print("Subscription 1:, Event: \($0)") })
        
        delay(2) { _ = intSequence.connect() }
        
        delay(4) {
            _ = intSequence
                .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
        }
        
        delay(8) {
            _ = intSequence
                .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
        }

    }
    static func sampleWithPublish() {
        print("sample with publish")
        let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
        
        _ = intSequence.subscribe({ print("Subscription 1: Event: \($0)") })
        
        delay(2) {
            _ = intSequence.connect()
        }
        
        delay(4) {
            _ = intSequence.subscribe({ print("Subscription 2:, Event: \($0)") })
        }
        delay(6) {
            _ = intSequence.subscribe({ print("Subscription 3:, Event: \($0)") })
        }
    }
    static func sampleWithoutConnectableOperators() {
        print("sample without connectable")
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        _ = interval.subscribe({ print("Subscriptiond: 1, event:\($0)") })
        delay(5) {
            _ = interval.subscribe({ print("Subscription: 2, Event: \($0)") })
        }
    }
}

struct RXCombination {
    static func concatTest() {
        print("concat")
        let disposeBag = DisposeBag()
        
        let subject1 = BehaviorSubject(value: "1")
        let subject2 = BehaviorSubject(value: "2")
        
        let subjectsSubject = BehaviorSubject(value: subject1)
        
        subjectsSubject.asObserver().concat().subscribe({ print($0) }).disposed(by: disposeBag)
        
        subject1.onNext("11")
        subject1.onNext("22")
        subjectsSubject.onNext(subject2)
        
        subject2.onNext("asdf")
        subject2.onNext("qqq")
        subject1.onCompleted()
        subject2.onNext("12asdf")
    }
    static func reduceTest() {
        print("reduce")
        let disposeBag = DisposeBag()
        Observable.of(10, 100, 1000).reduce(1, accumulator: +).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func toArrayTest() {
        print("to Array")
        let disposeBag = DisposeBag()
        
        Observable.range(start: 1, count: 10).toArray().subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func skipUntilTest() {
        print("skip until")
        let disposeBag = DisposeBag()
        
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        
        sourceSequence.skipUntil(referenceSequence).subscribe({ print($0) }).disposed(by: disposeBag)
        
        sourceSequence.onNext("1")
        sourceSequence.onNext("2")
        sourceSequence.onNext("3")
        
        referenceSequence.onNext("aa")
        
        sourceSequence.onNext("aaaa")
        sourceSequence.onNext("bbb")
    }
    static func skipWhileIndexTest() {
        print("skip while with index")
        let disposeBag = DisposeBag()
        Observable.of(1, 2, 3, 4, 5, 6, 7, 8).enumerated().skipWhile({ $0.index < 4 }).map({ $0.element }).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func skipWhileTest() {
        print("skipWhile")
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4, 5, 6, 7).skipWhile({ $0 < 4 }).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func skipTest() {
        print("skip")
        let disposeBag = DisposeBag()
        
        Observable.of("1", "2", "3", "4").skip(2).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    
    static func takeUntilTest() {
        print("take until")
        let disposeBag = DisposeBag()
        
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        
        sourceSequence.takeUntil(referenceSequence).subscribe({ print($0) }).disposed(by: disposeBag)
        
        sourceSequence.onNext("1")
        sourceSequence.onNext("2")
        sourceSequence.onNext("3")
        
        referenceSequence.onNext("aa")
        
        sourceSequence.onNext("4")
        sourceSequence.onNext("5")
        referenceSequence.onNext("asdf")
        sourceSequence.onNext("6")
    }
    static func takeWhileTest() {
        print("take while")
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4, 5, 6, 7).takeWhile({ $0 < 4 }).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func takeLastTest() {
        print("takeLast")
        let disposeBag = DisposeBag()
        Observable.of("1", "2", "3", "4", "5").takeLast(3).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func takeTest() {
        print("take")
        let disposeBag = DisposeBag()
        
        Observable.of("1", "2", "3", "4").take(3).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func singleWithConditionsTest() {
        print("single with conditions")
        let disposeBag = DisposeBag()
        Observable.of("1", "2", "3", "4").single({ $0 == "2" }).subscribe({ print($0) }).disposed(by: disposeBag)
        
        Observable.of("2", "2", "3", "4", "3").single({ $0 == "3" }).subscribe({ print($0) }).disposed(by: disposeBag)
        
        Observable.of("2", "3", "2", "2", "4").single({ $0 == "7" }).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func singleTest() {
        print("single")
        let disposeBag = DisposeBag()
        Observable.of("1", "2", "3", "4").single().subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func elementAtTest() {
        print("elementAt")
        let disposeBag = DisposeBag()
        Observable.of("1", "2", "3", " 4", "5").elementAt(3).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func distinctUntilChangedTest() {
        print("distinctUntilChanged")
        let disposeBag = DisposeBag()
        Observable.of("1", "2", "5", "2", "5").distinctUntilChanged().subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func filterTest() {
        print("filter")
        let disposeBag = DisposeBag()
        
        Observable.of("1", "2", "3", "4", "5", "6", "6").filter({ $0 == "6" }).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func scanTest() {
        print("scan")
        let disposeBag = DisposeBag()
        
        Observable.of(10, 100, 1000).scan(1) { aggregateValue, newValue in
            aggregateValue + newValue
            }.subscribe({ print($0) }).disposed(by: disposeBag)
    }
    
    static func flatMapAndFlatMapLatestTest() {
        print("flatmap & flatMapLatest")
        let disposeBag = DisposeBag()
        struct Player {
            let score: BehaviorSubject<Int>
            
            init(score: Int) {
                self.score = BehaviorSubject(value: score)
            }
        }
        
        let player1 = Player(score: 80)
        let player2 = Player(score: 90)
        
        let player = BehaviorSubject(value: player1)
        player.asObserver().flatMap({ $0.score.asObservable() }).subscribe({ print($0) }).disposed(by: disposeBag)
        
        player1.score.onNext(85)
        player.onNext(player2)
        
        player1.score.onNext(95)
        player2.score.onNext(100)
        
        player2.score.onNext(110)
    }
    static func MapTest() {
        print("Map")
        let disposeBag = DisposeBag()
        Observable.of(1, 2, 3).map({ $0 * $0 }).subscribe({ print($0) }).disposed(by: disposeBag)
    }
    static func SwitchLatestTest() {
        print("SwitchLatest")
        let disposeBag = DisposeBag()
        
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "B")
        
        let subjectsSubject = BehaviorSubject(value: subject1)
        
        subjectsSubject.asObserver().switchLatest().subscribe({ print($0) }).disposed(by: disposeBag)
        
        subject1.onNext("啊")
        subject1.onNext("啊啊")
        
        subjectsSubject.onNext(subject2)
        
        subject1.onNext("aaa")
        subject2.onNext("qweqwe")
    }
    static func ArrayCombineLatestTest() {
        print("Array CombineLatest")
        let disposeBag = DisposeBag()
        
        let oneObservable = Observable.just("一")
        let twoObservable = Observable.from(["22", "22a", "22d"])
        let threeObservable = Observable.of("33", "33a", "33d", "33f")
        Observable.combineLatest([oneObservable, twoObservable, threeObservable]) {
            "\($0[0]) \($0[1]) \($0[2])"
            }.subscribe({ print($0) }).disposed(by: disposeBag)
        
    }
    
    static func combineLatestTest() {
        print("combineLatest")
        let disposeBag = DisposeBag()
        
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.combineLatest(stringSubject, intSubject) { stringElement, intElement in
            "\(stringElement) \(intElement)"
            }.subscribe({ print($0) }).disposed(by: disposeBag)
        
        stringSubject.onNext("A")
        
        stringSubject.onNext("B")
        intSubject.onNext(1)
        
        intSubject.onNext(2)
        stringSubject.onNext("AB")
    }
    
    static func zipTest() {
        print("zip")
        let disposeBag = DisposeBag()
        
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject) { stringElement, intElement in
            "\(stringElement) \(intElement)"
            }.subscribe({ print($0) }).disposed(by: disposeBag)
        
        stringSubject.onNext("A")
        stringSubject.onNext("B")
        
        intSubject.onNext(1)
        intSubject.onNext(2)
        
        stringSubject.onNext("AB")
        intSubject.onNext(3)
    }
    static func startWithTest() {
        print("startWith")
        let disposeBag = DisposeBag()
        Observable.of("1", "2", "3", "4")
            .startWith("一")
            .startWith("二")
            .startWith("三", "A", "B")
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    static func mergeTest() {
        print("merge")
        let disposeBag = DisposeBag()
        
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        Observable.of(subject1, subject2).merge().subscribe({ print($0) }).disposed(by: disposeBag)
        
        subject1.onNext("A")
        subject1.onNext("B")
        
        subject2.onNext("1")
        subject2.onNext("2")
        
        subject1.onNext("AB")
        subject2.onNext("3")
        
    }
    
}

struct RXSubject {
    static func test() {
//        RXSubject.replayTest()
        RXSubject.behaviorTest()
    }
    
    static func behaviorTest() {
        print("BehaviorTest")
        let disposeBag = DisposeBag()
        let subject = BehaviorSubject(value: "我")
        
        subject.addObserver("1").disposed(by: disposeBag)
        subject.onNext("开始1-1")
        subject.onNext("开始1-2")
        
        subject.addObserver("2").disposed(by: disposeBag)
        subject.onNext("开始2-1")
        subject.onNext("开始2-2")
        
        subject.addObserver("3").disposed(by: disposeBag)
        subject.onNext("开始3-1")
        subject.onNext("开始3-2")
    }
    
    static func replayTest() {
        print("ReplayTest")
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        subject.addObserver("1").disposed(by: disposeBag)
        subject.onNext("开始1-1")
        subject.onNext("开始1-2")
        
        subject.addObserver("2").disposed(by: disposeBag)
        subject.onNext("开始2-1")
        subject.onNext("开始2-2")
    }
    
    static func publishTest() {
        print("publishSubject")
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        
        subject.addObserver("1").disposed(by: disposeBag)
        subject.onNext("开始1")
        subject.onNext("开始2")
        
        subject.addObserver("2").disposed(by: disposeBag)
        subject.onNext("开始2-1")
        subject.onNext("开始2-2")
    }
}

extension ObservableType {
    func addObserver(_ id: String) -> Disposable {
        return subscribe{ print("Subscription: \(id), Event:\($0)") }
    }
}

struct RXStudy {
//    static func ObTest() {
//        let scheduler = SerialDispatchQueueScheduler(qos: .default)
//        let subscription = Observable<Int>.interval(0.2, scheduler: scheduler).subscribe { (event) in
//            print(event)
//        }
//        Thread.sleep(forTimeInterval: 10)
//        subscription.dispose()
//    }
    func searchWikipedia(searchTerm: String) -> Observable<String> {
        return Observable<String>.create { (obOfString) -> Disposable in
            obOfString.onNext("开始")
            obOfString.onNext(searchTerm)
            obOfString.on(.completed)
            return Disposables.create()
        }
    }
    
    static func ObTest() {
//        let searchObserver = RXStudy().searchWikipedia(searchTerm: "阿斯顿发疯的")
//        searchObserver.subscribe { (event) in
//            print(event)
//        }
        RXStudy.testMyInterval()
    }
    
    func myInterval(_ interval: DispatchTimeInterval) -> Observable<Int> {
        return Observable.create { (observer) -> Disposable in
            print("Subscribed")
            let timer = DispatchSource.makeTimerSource(flags: .strict, queue: .global())
            timer.schedule(deadline: DispatchTime.now() + interval, repeating: interval)
            let disposable = Disposables.create {
                print("Disposed")
                timer.cancel()
            }
            var next = 0
            timer.setEventHandler {
                guard !disposable.isDisposed else { return }
                observer.onNext(next)
                next += 1
            }
            timer.resume()
            return disposable
        }
    }
    
    static func testMyInterval() {
        let counter = RXStudy().myInterval(.milliseconds(100))
        print("start")
        let disposable = counter.subscribe { (event) in
            print(event)
        }
        Thread.sleep(forTimeInterval: 10)
        disposable.dispose()
    }
}



