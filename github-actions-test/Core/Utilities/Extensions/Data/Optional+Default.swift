//
//  Optional+Default.swift
//  LCore
//
//  Created by Ünal Öztürk on 08.07.2021.
//

import Foundation

extension Int: DefaultValue {
    public static var defaultValue: Int { return 0 }
}

extension Double: DefaultValue {
    public static var defaultValue: Double { return 0.0 }
}

extension Float: DefaultValue {
    public static var defaultValue: Float { return 0.0 }
}

extension String: DefaultValue {
    public static var defaultValue: String { return "" }
}

extension Bool: DefaultValue {
    public static var defaultValue: Bool { return false }
}

extension Array: DefaultValue {
    public static var defaultValue: [Element] { return [] }
}
