//
//  PropertyTest.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/10/19.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

class PropertyTest {
    static func testAll() {
        debugExample("Creation") {
            let mutableProperty = MutableProperty(1)
            print("Property has initial value \(mutableProperty.value)")
            mutableProperty.producer.startWithValues({ (value) in
                print("mutableProperty.producer received \(value)")
            })
            mutableProperty.signal.observeValues({ (value) in
                print("mutableProperty.signal received \(value)")
            })
            mutableProperty.value = 2
            let property = Property(mutableProperty)
            property.signal.observeValues({ (value) in
                print("property.signal received \(value)")
            })
            mutableProperty.value = 3
        }
        debugExample("Binding from SignalProducer") {
            let producer = SignalProducer<Int, NoError>({ (observer, _) in
                observer.send(value: 1)
                observer.send(value: 2)
                observer.sendCompleted()
            })
            let property = MutableProperty(0)
            property.producer.startWithValues({ (value) in
                print("Property received \(value)")
            })
            property <~ producer
        }
        debugExample("Binding form Signal") {
            let (signal, observer) = Signal<Int, NoError>.pipe()
            let property = MutableProperty(0)
            property.producer.startWithValues({ (value) in
                print("Property received \(value)")
            })
            property <~ signal
            observer.send(value: 1)
            observer.send(value: 2)
        }
        debugExample("Binding other property") {
            let property = MutableProperty(0)
            property.producer.startWithValues({ (value) in
                print("Property received \(value)")
            })
            let otherProperty = MutableProperty(0)
            property <~ otherProperty
            otherProperty.value = 2
            otherProperty.value = 3
        }
        debugExample("map") {
            let property = MutableProperty(0)
            let mapped = property.map({ $0 * 2 })
            mapped.producer.startWithValues({ (value) in
                print("Mapped property received \(value)")
            })
            property.value = 1
            property.value = 2
        }
        debugExample("skipRepeats") {
            let property = MutableProperty(1)
            let skipRepeatsProperty = property.skipRepeats()
            property.producer.startWithValues({ (value) in
                print("Property received \(value)")
            })
            skipRepeatsProperty.producer.startWithValues({ (value) in
                print("Skip-Repeats property received \(value)")
            })
            property.value = 0
            property.value = 1
            property.value = 1
            property.value = 0
        }
        debugExample("uniqueValues") {
            let property = MutableProperty(0)
            let unique = property.uniqueValues()
            property.producer.startWithValues({ (value) in
                print("Property reveived \(value)")
            })
            unique.producer.startWithValues({ (value) in
                print("Unique values property received \(value)")
            })
            property.value = 0
            property.value = 1
            property.value = 1
            property.value = 0
        }
        debugExample("combineLatest") {
            let propertyA = MutableProperty(0)
            let propertyB = MutableProperty("A")
            let combined = propertyA.combineLatest(with: propertyB)
            combined.producer.startWithValues({ (value) in
                print("Combined property received \(value)")
            })
            propertyA.zip(with: propertyB).producer.startWithValues({ (value) in
                print("zip property received \(value)")
            })
            propertyA.value = 1
            propertyB.value = "B"
            propertyB.value = "C"
            propertyB.value = "D"
            propertyA.value = 2
        }
        debugExample("flatten") {
            let property1 = MutableProperty("0")
            let property2 = MutableProperty("A")
            let property3 = MutableProperty("！")
            let property = MutableProperty(property1)
            property.flatten(.latest).producer.startWithValues({ (value) in
                print("Flattened property received \(value)")
            })
            property1.value = "1"
            property.value = property2
            property1.value = "2"
            property.value = property3
        }
    }
}







