//
//  String+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension String {
    var asDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]) ?? [String: Any]()
    }

    var asArray: [Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]) ?? [Any]()
    }

    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }

    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }

    func addTLIconToBegin() -> String {
        return "₺" + self
    }

    func add(prefix: String) -> String {
           return prefix + self
    }

    func add(suffix: String) -> String {
           return self + suffix
    }

    var formattedCardNumber: String {
        let trimmedString = self.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if arrOfCharacters.count > 0 {
            for i in 0...arrOfCharacters.count - 1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if (i + 1) % 4 == 0 && i + 1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }

    var currencyInputFormatting: String? {
        var number: NSNumber?
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "₺"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex?.stringByReplacingMatches(
            in: amountWithPrefix,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSRange(location: 0, length: self.count),
            withTemplate: ""
        ) ?? ""

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number ?? 0)
    }

    var removeFormatCurrency: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₺"
        formatter.decimalSeparator = ","
        return Double(truncating: formatter.number(from: self) ?? 0)
    }
}
