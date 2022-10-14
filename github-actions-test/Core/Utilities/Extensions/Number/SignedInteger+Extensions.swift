//
//  SignedInteger+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension SignedInteger {
    var abs: Self {
        return Swift.abs(self)
    }

    var isPositive: Bool {
        return self > 0
    }

    var isNegative: Bool {
        return self < 0
    }

    var isEven: Bool {
        return (self % 2) == 0
    }

    var isOdd: Bool {
        return (self % 2) != 0
    }

    var timeString: String {
        guard self > 0 else {
            return "0 sec"
        }
        if self < 60 {
            return "\(self) sec"
        }
        if self < 3600 {
            return "\(self / 60) min"
        }
        let hours = self / 3600
        let mins = (self % 3600) / 60

        if hours != 0, mins == 0 {
            return "\(hours)h"
        }
        return "\(hours)h \(mins)m"
    }
}
