//
//  NSAttributedString+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit

extension NSAttributedString {
    var bolded: NSAttributedString {
        guard !string.isEmpty else { return self }

        let pointSize: CGFloat
        if let font = attribute(.font, at: 0, effectiveRange: nil) as? UIFont {
            pointSize = font.pointSize
        } else {
            #if os(tvOS) || os(watchOS)
            pointSize = UIFont.preferredFont(forTextStyle: .headline).pointSize
            #else
            pointSize = UIFont.systemFontSize
            #endif
        }
        return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: pointSize)])
    }

    var underlined: NSAttributedString {
        return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    var italicized: NSAttributedString {
        guard !string.isEmpty else { return self }

        let pointSize: CGFloat
        if let font = attribute(.font, at: 0, effectiveRange: nil) as? UIFont {
            pointSize = font.pointSize
        } else {
            #if os(tvOS) || os(watchOS)
            pointSize = UIFont.preferredFont(forTextStyle: .headline).pointSize
            #else
            pointSize = UIFont.systemFontSize
            #endif
        }
        return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: pointSize)])
    }

    var strikethrough: NSAttributedString {
        return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)])
    }

    var attributes: [Key: Any] {
        guard length > 0 else { return [:] }
        return attributes(at: 0, effectiveRange: nil)
    }
}

// MARK: - Methods
extension NSAttributedString {
    func applying(attributes: [Key: Any]) -> NSAttributedString {
        guard !string.isEmpty else { return self }

        let copy = NSMutableAttributedString(attributedString: self)
        copy.addAttributes(attributes, range: NSRange(0..<length))
        return copy
    }

    func colored(with color: UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }

    func applying(attributes: [Key: Any],
                  toRangesMatching pattern: String,
                  options: NSRegularExpression.Options = []) -> NSAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: options) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        let result = NSMutableAttributedString(attributedString: self)

        for match in matches {
            result.addAttributes(attributes, range: match.range)
        }

        return result
    }

    func applying<T: StringProtocol>(attributes: [Key: Any],
                                     toOccurrencesOf target: T) -> NSAttributedString {
        let pattern = "\\Q\(target)\\E"

        return applying(attributes: attributes, toRangesMatching: pattern)
    }

    @objc public func lineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        NSMutableAttributedString(attributedString: self).lineSpacing(spacing)
    }
}

extension NSMutableAttributedString {
    open func underline(_ text: String? = nil, style: NSUnderlineStyle = .single) -> Self {
        addAttribute(.underlineStyle, value: style.rawValue, range: range(of: text))
        return self
    }

    open func foregroundColor(_ color: UIColor, for text: String? = nil) -> Self {
        addAttribute(.foregroundColor, value: color, range: range(of: text))
        return self
    }

    open func backgroundColor(_ color: UIColor, for text: String? = nil) -> Self {
        addAttribute(.backgroundColor, value: color, range: range(of: text))
        return self
    }

    open func font(_ font: UIFont, for text: String? = nil) -> Self {
        addAttribute(.font, value: font, range: range(of: text))
        return self
    }

    open func link(url: URL?, text: String) -> Self {
        guard let url = url else {
            return self
        }

        addAttribute(.link, value: url, range: range(of: text))
        return self
    }

    public override func lineSpacing(_ spacing: CGFloat) -> Self {
        paragraphStyle(\.lineSpacing, to: spacing, range: range(of: nil))
        return self
    }

    open func textAlignment(_ textAlignment: NSTextAlignment, for text: String? = nil) -> Self {
        paragraphStyle(\.alignment, to: textAlignment, range: range(of: text))
        return self
    }

    private func paragraphStyle<T>(
        _ keyPath: WritableKeyPath<NSMutableParagraphStyle, T>,
        to value: T,
        range: NSRange
    ) {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle[keyPath: keyPath] = value
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
    }

    private func range(of text: String?) -> NSRange {
        let range: NSRange

        if let text = text {
            range = (string as NSString).range(of: text)
        } else {
            range = NSRange(location: 0, length: string.count)
        }

        return range
    }

    @discardableResult func regular(
        _ text: String,
        size: CGFloat = 14,
        color: UIColor = .softBlack
    ) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.regular(size),
                                                  .foregroundColor: color]
        let regular = NSMutableAttributedString(string: "\(text)", attributes: attrs)
        self.append(regular)
        return self
    }

    @discardableResult func bold(
        _ text: String,
        size: CGFloat = 14,
        color: UIColor = .softBlack
    ) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.bold(size),
                                                  .foregroundColor: color]
        let boldString = NSMutableAttributedString(string: "\(text)", attributes: attrs)
        self.append(boldString)
        return self
    }

    @discardableResult func medium(
        _ text: String,
        size: CGFloat = 14,
        color: UIColor = .softBlack
    ) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.medium(size),
                                                  .foregroundColor: color]
        let boldString = NSMutableAttributedString(string: "\(text)", attributes: attrs)
        self.append(boldString)
        return self
    }
}

// MARK: - Operators
extension NSAttributedString {
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }

    static func += (lhs: inout NSAttributedString, rhs: String) {
        lhs += NSAttributedString(string: rhs)
    }

    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + NSAttributedString(string: rhs)
    }
}
