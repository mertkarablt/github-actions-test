//
//  UIFont+Styles.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit

extension UIFont {
    // MARK: Headline
    public static var headline1: UIFont {
        return .regular(44)
    }
    public static var headline2: UIFont {
        return .bold(32)
    }
    public static var headline3: UIFont {
        return .bold(20)
    }
    public static var headline4: UIFont {
        return .regular(18)
    }

    // MARK: Subtitle
    public static var subtitle1: UIFont {
        return .medium(16)
    }
    public static var subtitle2: UIFont {
        return .medium(14)
    }

    // MARK: Subtitle
    public static var body1: UIFont {
        return .regular(13)
    }
    public static var body2: UIFont {
        return .medium(13)
    }

    // MARK: Button
    public static var button1: UIFont {
        return .bold(14)
    }
    public static var button2: UIFont {
        return .bold(11)
    }

    // MARK: Caption
    public static var caption: UIFont {
        return .bold(12)
    }

    // MARK: Overline
    public static var overline: UIFont {
        return .bold(9)
    }

    // MARK: Tiny
    public static var tiny: UIFont {
        return .regular(11)
    }
}
