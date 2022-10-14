//
//  UIView+Constraints.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIView {
    func findConstraint(attribute: NSLayoutConstraint.Attribute, for view: UIView) -> NSLayoutConstraint? {
        let constraint = constraints.first {
            ($0.firstAttribute == attribute && $0.firstItem as? UIView == view) ||
                ($0.secondAttribute == attribute && $0.secondItem as? UIView == view)
        }
        return constraint ?? superview?.findConstraint(attribute: attribute, for: view)
    }

    var widthConstraint: NSLayoutConstraint? {
        findConstraint(attribute: .width, for: self)
    }

    var heightConstraint: NSLayoutConstraint? {
        findConstraint(attribute: .height, for: self)
    }

    var leadingConstraint: NSLayoutConstraint? {
        findConstraint(attribute: .leading, for: self)
    }

    var trailingConstraint: NSLayoutConstraint? {
        findConstraint(attribute: .trailing, for: self)
    }

    var topConstraint: NSLayoutConstraint? {
        findConstraint(attribute: .top, for: self)
    }

    var bottomConstraint: NSLayoutConstraint? {
        findConstraint(attribute: .bottom, for: self)
    }
}
