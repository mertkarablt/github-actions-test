//
//  Bool+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Bool {
    var int: Int {
        return self ? 1 : 0
    }

    var string: String {
        return self ? "true" : "false"
    }
}
