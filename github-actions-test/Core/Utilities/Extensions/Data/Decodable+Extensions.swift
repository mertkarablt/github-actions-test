//
//  Decodable+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Decodable {
    init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let parsed = try? decoder.decode(Self.self, from: data) else { return nil }
        self = parsed
    }

    init?(JSONString: String?) {
        guard let json = JSONString,
              let jsonData = json.data(using: .utf8),
              let anInstance = try? JSONDecoder().decode(Self.self, from: jsonData) else {
            return nil
        }
        self = anInstance
    }
}
