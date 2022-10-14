//
//  AnyEncodable.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

public struct AnyEncodable: Encodable {
    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    public func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
