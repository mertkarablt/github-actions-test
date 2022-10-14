//
//  Comparable+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Comparable {
    func isBetween(_ range: ClosedRange<Self>) -> Bool {
        return range ~= self
    }

    func clamped(to range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(self, range.upperBound))
    }
}
