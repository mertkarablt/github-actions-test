//
//  Encodable+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Encodable {
    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }

    func toString() -> String? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }

    func asDictionary() -> [String: Any?]? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any?] else {
            return nil
        }
        return dictionary
    }
}
