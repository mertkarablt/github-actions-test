//
//  UITextField+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UITextField {
    convenience init(
        placeholder: TextType?,
        text: TextType? = nil,
        textAlignment: NSTextAlignment = .natural,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        textColor: UIColor? = .black,
        font: UIFont? = nil,
        borderStyle: BorderStyle = .none,
        backgroundColor: UIColor? = .white,
        tintColor: UIColor? = nil
    ) {
        self.init()

        if let aPlaceholder = placeholder {
            switch aPlaceholder {
            case .plain(let string):
                self.placeholder = string
            case .attributed(let string):
                self.attributedPlaceholder = string
            case .empty:
                self.attributedPlaceholder = nil
                self.placeholder = nil
            }
        }

        if let aText = text {
            switch aText {
            case .plain(let string):
                self.text = string
            case .attributed(let string):
                self.attributedText = string
            case .empty:
                self.attributedText = nil
                self.text = nil
            }
        }

        self.textAlignment = textAlignment
        self.keyboardType = keyboardType
        if let textContentType = textContentType {
            self.textContentType = textContentType
        }
        self.textColor = textColor

        if let aFont = font {
            self.font = aFont
        }

        self.borderStyle = borderStyle

        self.backgroundColor = backgroundColor
        if let color = tintColor {
            self.tintColor = color
        }
    }
}

extension UITextField {
    var isEmpty: Bool {
        return text?.isEmpty == true
    }

    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    @IBInspectable var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }

    @IBInspectable var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
}

extension UITextField {
    func clearText() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
    }

    func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }

    func addPaddingLeftIcon(
        _ image: UIImage,
        padding: CGFloat
    ) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        leftView = iconView
        leftViewMode = .always
    }

    func addPaddingRightIcon(
        _ image: UIImage,
        padding: CGFloat
    ) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
    }
}
