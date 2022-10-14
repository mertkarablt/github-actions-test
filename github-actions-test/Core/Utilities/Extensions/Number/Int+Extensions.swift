//
//  Int+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import CoreGraphics

extension Int {
    var countableRange: CountableRange<Int> {
        return 0..<self
    }

    var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }

    var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }

    var uInt: UInt {
        return UInt(self)
    }

    var double: Double {
        return Double(self)
    }

    var float: Float {
        return Float(self)
    }

    var cgFloat: CGFloat {
        return CGFloat(self)
    }

    var digits: [Int] {
        guard self != 0 else { return [0] }
        var digits = [Int]()
        var number = abs

        while number != 0 {
            let xNumber = number % 10
            digits.append(xNumber)
            number /= 10
        }

        digits.reverse()
        return digits
    }

    var digitsCount: Int {
        guard self != 0 else { return 1 }
        let number = Double(abs)
        return Int(log10(number) + 1)
    }

    var decimalNumber: NSDecimalNumber {
        return NSDecimalNumber(decimal: Decimal(self))
    }
}

// MARK: - Methods
extension Int {
    func roundToNearest(_ number: Int) -> Int {
        return number == 0 ? self : Int(round(Double(self) / Double(number))) * number
    }
}
