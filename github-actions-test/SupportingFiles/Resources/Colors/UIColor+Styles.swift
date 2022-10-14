//
//  UIColor+Styles.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit

extension UIColor {
    /// Hex: 00BAD3
    public static var blue: UIColor { return UIColor(named: "blue") ?? Color(named: .blue) }
    /// Hex: 71E6F5
    public static var lightBlue: UIColor { return UIColor(named: "lightBlue") ?? Color(named: .lightBlue) }
    /// Hex: F0FBFD
    public static var ultraLightBlue: UIColor { return UIColor(named: "ultraLightBlue") ?? Color(named: .ultraLightBlue) }

    /// Hex: 333333
    public static var softBlack: UIColor { return UIColor(named: "softBlack") ?? Color(named: .softBlack) }
    /// Hex: 8D939C
    public static var darkGray: UIColor { return UIColor(named: "darkGray") ?? Color(named: .darkGray) }
    /// Hex: E5E7E9
    public static var lightGray: UIColor { return UIColor(named: "lightGray") ?? Color(named: .lightGray) }
    /// Hex: F3F6FA
    public static var ultraLightGray: UIColor { return UIColor(named: "ultraLightGray") ?? Color(named: .ultraLightGray) }

    /// Hex: 4CAF50
    public static var green: UIColor { return UIColor(named: "green") ?? Color(named: .green) }
    /// Hex: F28B6B
    public static var orange: UIColor { return UIColor(named: "orange") ?? Color(named: .orange) }
    /// Hex: F34133
    public static var red: UIColor { return UIColor(named: "red") ?? Color(named: .red) }

    public static var gradientBlue: [UIColor] {
        return [UIColor(named: "lightBlue") ?? Color(named: .lightBlue),
                UIColor(named: "blue") ?? Color(named: .blue)]
    }
}
