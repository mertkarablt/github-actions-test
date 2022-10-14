//
//  UITextView+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UITextView {
    convenience init(
        text: TextType,
        font: UIFont? = nil,
        textColor: UIColor? = .black,
        isEditable: Bool = true,
        allowsEditingTextAttributes: Bool = false,
        textAlignment: NSTextAlignment = .natural,
        textContainerInset: UIEdgeInsets = .zero,
        backgroundColor: UIColor? = .white,
        tintColor: UIColor? = nil
    ) {
        self.init()

        switch text {
        case .plain(let string):
            self.text = string
        case .attributed(let string):
            self.attributedText = string
        case .empty:
            self.attributedText = nil
            self.text = nil
        }

        if let aFont = font {
            self.font = aFont
        }

        self.textColor = textColor
        self.isEditable = isEditable
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        self.textAlignment = textAlignment
        self.textContainerInset = textContainerInset
        self.backgroundColor = backgroundColor

        if let color = tintColor {
            self.tintColor = color
        }
    }

    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    func scrollToBottom() {
        let range = NSRange(location: (text as NSString).length - 1, length: 1)
        scrollRangeToVisible(range)
    }

    func scrollToTop() {
        let range = NSRange(location: 0, length: 1)
        scrollRangeToVisible(range)
    }

    func wrapToContent() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
        contentOffset = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(0, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
