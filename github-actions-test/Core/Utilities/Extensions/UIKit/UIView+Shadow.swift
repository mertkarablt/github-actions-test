//
//  UIView+Shadow.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIView {
    public func configureShadow(
        color: UIColor = .black,
        offset: CGSize = .zero,
        radius: CGFloat = 6.0,
        cornerRadius: CGFloat = 8.0,
        opacity: Float = 0.12
    ) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }

    public func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = .zero
        layer.shadowRadius = .zero
        layer.shadowOffset = .zero
        layer.shadowPath = nil
    }

    public func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
        masksToBounds = false
    }
}
