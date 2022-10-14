//
//  Optional+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        guard let collection = self else { return true }
        return collection.isEmpty
    }

    var nonEmpty: Wrapped? {
        guard let collection = self else { return nil }
        guard !collection.isEmpty else { return nil }
        return collection
    }
}

public protocol DefaultValue {
    associatedtype DefaultType: DefaultValue where DefaultType.DefaultType == Self
    static var defaultValue: DefaultType { get }
}

public extension Optional where Wrapped: DefaultValue, Wrapped.DefaultType == Wrapped {
    var required: Wrapped {
        defer {
            if self == nil {
                assertionFailure("Value can not be nil because you try to unwrap value")
            }
        }
        return valueOrDefault
    }

    var valueOrDefault: Wrapped {
        guard let notNilSelf = self else {
            return Wrapped.defaultValue
        }
        return notNilSelf
    }
}

public extension Optional {
    var required: Wrapped {
        guard let notNilSelf = self else {
            return self!
        }
        return notNilSelf
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}
