//
//  Double+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import CoreGraphics

extension Double {
    var int: Int {
        return Int(self)
    }

    var float: Float {
        return Float(self)
    }

    var cgFloat: CGFloat {
        return CGFloat(self)
    }

    var personaPriceFormatted: String {
        return String(format: "%.2f", self / 100).replacingOccurrences(of: ".", with: ",")
    }

    var ridZero: String {
         return String(format: "%g", self)
    }
}
