//
//  Sequence+Extensions.swift
//  kapida
//
//  Created by Ünal Öztürk on 18.07.2022.
//

import Foundation

extension Sequence {
    func limit(_ max: Int) -> [Element] {
        return self.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }
}
