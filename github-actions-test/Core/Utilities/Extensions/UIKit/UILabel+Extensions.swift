//
//  UILabel+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String?) {
        self.init()
        self.text = text
    }

    convenience init(
        text: TextType,
        textAlignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        textColor: UIColor? = .black,
        font: UIFont? = nil,
        underlinedColor: UIColor? = nil,
        minimumScaleFactor: CGFloat = 1.0,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        backgroundColor: UIColor? = .clear
    ) {
        self.init()

        switch text {
        case .plain(let string):
            self.text = string
        case .attributed(let attributedText):
            self.attributedText = attributedText
        case .empty:
            self.attributedText = nil
            self.text = nil
        }

        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor

        if let aFont = font {
            self.font = aFont
        }

        if minimumScaleFactor < 1 {
            self.adjustsFontSizeToFitWidth = true
            self.minimumScaleFactor = minimumScaleFactor
        }

        if let underlinedColor = underlinedColor {
            attributedText = self.text?.underlined(color: underlinedColor)
        }

        self.lineBreakMode = lineBreakMode
        self.backgroundColor = backgroundColor
    }

    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
