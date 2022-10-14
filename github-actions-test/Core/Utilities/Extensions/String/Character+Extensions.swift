//
//  Character+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Character {
    var int: Int? {
        return Int(String(self))
    }

    var string: String {
        return String(self)
    }

    var lowercased: Character {
        return String(self).lowercased().first!
    }

    var uppercased: Character {
        return String(self).uppercased().first!
    }
}
