//
//  UIView+KeyboardHandlers.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIView {
    public func addKeyboardDismissHandler() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
            )
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

extension UIViewController {
    public func addKeyboardDismissHandler() {
        view.addKeyboardDismissHandler()
    }

    @objc public func dismissKeyboard() {
        view.dismissKeyboard()
    }
}
