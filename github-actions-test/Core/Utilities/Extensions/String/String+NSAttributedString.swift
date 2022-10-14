//
//  String+NSAttributedString.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit

extension String {
    var bold: NSAttributedString {
        return NSMutableAttributedString(
            string: self,
            attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }

    var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    var strikethrough: NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }

    var italic: NSAttributedString {
        return NSMutableAttributedString(
            string: self,
            attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }

    func underlined(color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: self,
                                                        attributes: attributes)
        return attributeString
    }

    func colored(with color: Color) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }

    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("html2AttributedString-error:", error)
            return nil
        }
    }
}
