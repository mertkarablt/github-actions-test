//
//  UIFont+Init.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit

extension UIFont {
    private enum LCFontName: String {
        case regular = "TTFors-Regular"
        case medium = "TTFors-Medium"
        case bold = "TTFors-DemiBold"
        case italic = "TTFors-Italic"
        case pantonExtraBold = "Panton-ExtraBold"

        var fileName: String {
            switch self {
            case .regular:
                return LCFontFileName.regular.rawValue
            case .medium:
                return LCFontFileName.medium.rawValue
            case .bold:
                return LCFontFileName.bold.rawValue
            case .italic:
                return LCFontFileName.italic.rawValue
            case .pantonExtraBold:
                return LCFontFileName.pantonExtraBold.rawValue
            }
        }
    }

    private enum LCFontFileName: String {
        case regular = "TTFors-Regular"
        case medium = "TTFors-Medium"
        case bold = "TTFors-DemiBold"
        case italic = "TTFors-Italic"
        case pantonExtraBold = "Panton-ExtraBold"
    }

    public class func regular(_ size: CGFloat) -> UIFont {
        return font(size: size, type: .regular)
    }

    public class func medium(_ size: CGFloat) -> UIFont {
        return font(size: size, type: .medium)
    }

    public class func bold(_ size: CGFloat) -> UIFont {
        return font(size: size, type: .bold)
    }

    public class func italic(_ size: CGFloat) -> UIFont {
        return font(size: size, type: .italic)
    }

    public class func pantonExtraBold(_ size: CGFloat) -> UIFont {
        return font(size: size, type: .pantonExtraBold)
    }

    private class func font(size: CGFloat, type: LCFontName) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            registerFont(name: type.fileName)
            return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        return font
    }

    private static func registerFont(name: String) {
        guard let pathForResourceString = Bundle.main.path(forResource: name, ofType: "ttf"),
              let fontData = NSData(contentsOfFile: pathForResourceString),
              let dataProvider = CGDataProvider(data: fontData),
              let fontRef = CGFont(dataProvider) else {
                  return
              }
        var error: UnsafeMutablePointer<Unmanaged<CFError>?>?
        if CTFontManagerRegisterGraphicsFont(fontRef, error) == false {
            return
        }
        error = nil
    }
}
