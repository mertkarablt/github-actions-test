//
//  Data+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }

    func prettyPrintedDictionary() -> [String: Any]? {
        let error: Error? = nil
        let strUTF8 = String(data: self, encoding: .utf8)
        let dataUTF8 = strUTF8?.data(using: .utf8)

        var dict: [String: Any]?
        do {
            if let dataUTF8 = dataUTF8 {
                dict = try JSONSerialization.jsonObject(with: dataUTF8, options: []) as? [String: Any]
            }
        } catch {
        }
        if let dict = dict {
            return dict
        } else {
            if let error = error {
                print("Error: \(error)")
                return nil
            }
        }
        return dict
    }

    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}
