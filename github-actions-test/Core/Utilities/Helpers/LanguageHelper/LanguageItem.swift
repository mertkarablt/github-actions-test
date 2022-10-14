//
//  LanguageItem.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

public enum LanguageType: String {
    case turkish = "tr"
    case english = "en"
}

public struct LanguageItem {
    public var title: String
    public var languageType: LanguageType
    public var isSelected: Bool

    public init(title: String,
                languageType: LanguageType,
                isSelected: Bool) {
        self.title = title
        self.languageType = languageType
        self.isSelected = isSelected
    }
}
