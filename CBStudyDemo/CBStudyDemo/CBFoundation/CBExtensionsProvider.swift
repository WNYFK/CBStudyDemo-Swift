//
//  CBExtensionsProvider.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2018/12/14.
//  Copyright © 2018 ChenBin. All rights reserved.
//

import Foundation

public protocol CBExtensionsProvider: class {}

extension CBExtensionsProvider {
    public static var cb: CBStaticExtensions<Self> {
        return CBStaticExtensions(self)
    }
    
    public var cb: CBExtensions<Self> {
        get { return CBExtensions(self) }
        set {
            print("new value")
        }
    }
}

public struct CBStaticExtensions<Base> {
    public let baseType: Base.Type
    
    fileprivate init(_ type: Base.Type) {
        self.baseType = type
    }
}
public struct CBExtensions<Base> {
    public let base: Base
    
    fileprivate init(_ base: Base) {
        self.base = base
    }
}
