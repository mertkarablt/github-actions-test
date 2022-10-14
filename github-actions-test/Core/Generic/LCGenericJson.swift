//
//  LCGenericJson.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

enum LCGenericJson: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: LCGenericJson])
    case array([LCGenericJson])

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string): try container.encode(string)
        case .int(let int): try container.encode(int)
        case .double(let double): try container.encode(double)
        case .bool(let bool): try container.encode(bool)
        case .object(let object): try container.encode(object)
        case .array(let array): try container.encode(array)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: LCGenericJson].self) {
            self = .object(value)
        } else if let value = try? container.decode([LCGenericJson].self) {
            self = .array(value)
        } else {
            throw DecodingError.typeMismatch(
                LCGenericJson.self,
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Not a JSON"
                )
            )
        }
    }
}
