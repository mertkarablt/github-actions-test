//
//  UITextView+HyperLink.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

public typealias LCHyperLink = (link: String, target: String)
extension UITextView {
    public func hyperLink(
        originalText: String,
        font: UIFont,
        textColor: UIColor = UIColor.black,
        alignment: NSTextAlignment = NSTextAlignment.left,
        lineHeight: CGFloat? = nil,
        lineSpacing: CGFloat = 0.1,
        hyperLinks: [LCHyperLink],
        linkColor: UIColor,
        linkFont: UIFont,
        underlined: Bool = false
    ) {
        textContainer.lineFragmentPadding = 0
        textContainerInset = .zero

        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        var height: CGFloat = lineHeight ?? 0
        if height == 0 {
            height = font.lineHeight
        }
        style.maximumLineHeight = height
        style.minimumLineHeight = height

        text = originalText
        let attributedOriginalText = NSMutableAttributedString(string: text)
        let linkRanges = hyperLinks.map { attributedOriginalText.mutableString.range(of: $0.link)
        }
        let fullRange = attributedOriginalText.mutableString.range(of: text)

        attributedOriginalText.addAttributes(
            [
                .paragraphStyle: style,
                .foregroundColor: textColor,
                .font: font
            ],
            range: fullRange)

        linkRanges.enumerated().forEach {
            attributedOriginalText.addAttribute(.link, value: hyperLinks[$0.offset].target, range: $0.element)
            attributedOriginalText.addAttribute(
                .foregroundColor,
                value: linkColor,
                range: $0.element)
            attributedOriginalText.addAttribute(
                .font,
                value: linkFont,
                range: $0.element)
            if underlined {
                attributedOriginalText.addAttribute(
                    .underlineStyle,
                    value: NSUnderlineStyle.single.rawValue,
                    range: $0.element)
            }
        }

        var attributes = [
            NSAttributedString.Key.foregroundColor: linkColor,
            NSAttributedString.Key.font: linkFont
        ] as [NSAttributedString.Key: Any]

        if underlined {
            attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: NSAttributedString.Key.underlineStyle)
        }

        self.linkTextAttributes = attributes

        self.attributedText = attributedOriginalText
    }
}
