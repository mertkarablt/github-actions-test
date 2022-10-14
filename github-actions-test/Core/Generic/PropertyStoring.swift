//
//  PropertyStoring.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

// swiftlint:disable implicitly_unwrapped_optional
public protocol PropertyStoring {
    associatedtype ObjectType
    func getAssociatedObject(_ key: UnsafeRawPointer!) -> ObjectType?
    func setAssociatedObject(_ key: UnsafeRawPointer!, newValue: ObjectType?)
}

extension PropertyStoring {
    public func getAssociatedObject(_ key: UnsafeRawPointer!) -> ObjectType? {
        guard let value = objc_getAssociatedObject(self, key) as? ObjectType else {
            return nil
        }
        return value
    }

    public func setAssociatedObject(_ key: UnsafeRawPointer!, newValue: ObjectType?) {
        objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
}
// swiftlint:enable implicitly_unwrapped_optional
