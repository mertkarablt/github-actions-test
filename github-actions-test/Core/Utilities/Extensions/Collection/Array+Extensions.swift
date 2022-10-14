//
//  Array+Extensions.swift
//  LCore
//
//  Created by Muhammed Karakul on 24.02.2021.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var remaining = self.count % size
        return stride(from: 0, to: count, by: size).map {
            var arraySize = $0 + size
            if remaining > 0 {
                arraySize += 1
                remaining -= 1
            }
            return Array(self[$0 ..< Swift.min(arraySize, count)])
        }
    }
}
