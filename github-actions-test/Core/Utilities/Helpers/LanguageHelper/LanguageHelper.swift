//
//  LanguageHelper.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Localize_Swift

public class LanguageHelper {
    public static var currentLanguage: String?
    public static var path: String?
    public static var bundle: Bundle?

    public static func changeLanguageTo(_ language: LanguageType) {
        currentLanguage = getCurrentLanguage()
        Localize.setCurrentLanguage(language.rawValue.lowercased())
    }

    public static func localizedString(_ key: String) -> String? {
        if currentLanguage != nil {
            return NSLocalizedString(key, tableName: currentLanguage, bundle: Bundle.main, value: key, comment: "")
        }
        return key
    }

    public static func getCurrentLanguage() -> String {
        return Localize.displayNameWithCode(getCurrentLanguageCode().rawValue)
    }

    public static func getCurrentLanguageCode() -> LanguageType {
        return Localize.currentLanguage() == LanguageType.turkish.rawValue ? .turkish : .english
    }
}
