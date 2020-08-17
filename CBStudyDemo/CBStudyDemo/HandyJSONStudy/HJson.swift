//
//  HJson.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/7/17.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation
import HandyJSON

class BasicTypes: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!
    
    required init() {}
}

struct HandyJSONTest {
    static func test() {
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = BasicTypes.deserialize(from: jsonString) {
            print(object.int)
            print(object.doubleOptional)
            print(object.stringImplicitlyUnwrapped)
        }
    }
}
