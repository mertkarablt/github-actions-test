//
//  FloatingPoint+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension FloatingPoint {
    var abs: Self {
        return Swift.abs(self)
    }

    var isPositive: Bool {
        return self > 0
    }

    var isNegative: Bool {
        return self < 0
    }

    var ceil: Self {
        return Foundation.ceil(self)
    }

    var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }

    var floor: Self {
        return Foundation.floor(self)
    }

    var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}
