//
//  UIButton+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIButton {
    convenience init(
        type: ButtonType,
        title: TextType? = nil,
        image: UIImage? = nil,
        titleFont: UIFont? = nil,
        alignment: ContentHorizontalAlignment = .center,
        contentEdgeInsets: UIEdgeInsets = .init(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0),
        cornerRadius: CGFloat? = 0.0,
        isEnabled: Bool = true,
        backgroundColor: UIColor? = .white,
        titleColor: UIColor? = .black
    ) {
        self.init(type: type)

        if let aTitle = title {
            switch aTitle {
            case .plain(let string):
                setTitle(string, for: .normal)
            case .attributed(let string):
                setAttributedTitle(string, for: .normal)
            case .empty:
                setAttributedTitle(nil, for: .normal)
                setTitle(nil, for: .normal)
            }
        }

        setImage(image, for: .normal)

        if let font = titleFont {
            titleLabel?.font = font
        }
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }

        self.contentHorizontalAlignment = alignment
        self.contentEdgeInsets = contentEdgeInsets
        self.isEnabled = isEnabled

        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
    }
}

extension UIButton {
    @IBInspectable
    var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    @IBInspectable
    var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    @IBInspectable
    var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    @IBInspectable
    var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    @IBInspectable
    var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    @IBInspectable
    var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
}

extension UIButton {
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }

    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { setTitleColor(color, for: $0) }
    }

    func setTitleForAllStates(_ title: String) {
        states.forEach { setTitle(title, for: $0) }
    }

    func centerTextAndImage(
        imageAboveText: Bool = false,
        spacing: CGFloat
    ) {
        if imageAboveText {
            // https://stackoverflow.com/questions/2451223/#7199529
            guard
                let imageSize = imageView?.image?.size,
                let text = titleLabel?.text,
                let font = titleLabel?.font else { return }

            let titleSize = text.size(withAttributes: [.font: font])

            let titleOffset = -(imageSize.height + spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

            let imageOffset = -(titleSize.height + spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }

    func setUnderlinedTitle(
        title: String,
        font: UIFont,
        color: UIColor,
        state: UIControl.State
    ) {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.underlineStyle: 1
        ]

        let attributedString = NSMutableAttributedString(string: "")
        let buttonTitleStr = NSMutableAttributedString(string: title, attributes: attrs)
        attributedString.append(buttonTitleStr)
        setAttributedTitle(attributedString, for: state)
    }
}
