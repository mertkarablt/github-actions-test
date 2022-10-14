//
//  UserDefaults+Codable.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension UserDefaults {
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    func save<T: Codable>(item: T,
                          forKey key: String,
                          usingEncoder encoder: JSONEncoder = JSONEncoder()
    ) {
        do {
            let data = try encoder.encode(item)
            set(data, forKey: key)
            synchronize()
        } catch let error {
            print("Failed to encode with error \(error)")
        }
    }

    func read<T: Codable>(_ type: T.Type,
                          with key: String,
                          usingDecoder decoder: JSONDecoder = JSONDecoder()
    ) -> T? {
        guard let data = object(forKey: key) as? Data else { return nil }
        do {
            let restoredItem = try decoder.decode(type.self, from: data)
            return restoredItem
        } catch let error {
            print("Failed to decode with error \(error)")
            return nil
        }
    }
}
