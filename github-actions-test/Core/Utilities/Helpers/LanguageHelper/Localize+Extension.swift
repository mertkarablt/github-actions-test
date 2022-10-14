//
//  Localize+Extension.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Localize_Swift

extension Localize {
    open class func displayNameWithCode(_ code: String) -> String {
        let locale = NSLocale(localeIdentifier: code)
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: code) {
            return displayName
        }
        return String()
    }
}
