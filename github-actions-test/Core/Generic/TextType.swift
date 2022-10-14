//
//  TextType.swift
//  StarterBeta
//
//  Created by Can Akkaya on 6.02.2020.
//  Copyright © 2020 Loodos. All rights reserved.
//

import Foundation

/// Text type is used with UIKit elements that has both text and attributedText properties.
///
/// - plain: String.
/// - attributed: NSAttributedString.
/// - empty: Empty string.
public enum TextType {
    /// String.
    case plain(String)
    /// NSAttributedString.
    case attributed(NSAttributedString)
    /// Empty string.
    case empty
}
