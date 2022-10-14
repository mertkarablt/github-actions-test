//
//  Float+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import CoreGraphics

extension Float {
    var int: Int {
        return Int(self)
    }

    var double: Double {
        return Double(self)
    }

    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
