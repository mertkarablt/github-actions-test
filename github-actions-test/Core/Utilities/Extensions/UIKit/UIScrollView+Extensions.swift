//
//  UIScrollView+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIScrollView {
    convenience init(
        isScrollEnabled: Bool = true,
        isDirectionalLockEnabled: Bool = false,
        isPagingEnabled: Bool = false,
        scrollsToTop: Bool = true,
        bounces: Bool = true,
        alwaysBounceVertical: Bool = false,
        alwaysBounceHorizontal: Bool = false,
        minimumZoomScale: CGFloat = 1.0,
        maximumZoomScale: CGFloat = 1.0,
        bouncesZoom: Bool = true,
        keyboardDismissMode: UIScrollView.KeyboardDismissMode = .none,
        backgroundColor: UIColor? = .white
    ) {
        self.init()

        self.isScrollEnabled = isScrollEnabled
        self.isDirectionalLockEnabled = isDirectionalLockEnabled
        self.isPagingEnabled = isPagingEnabled
        self.scrollsToTop = scrollsToTop
        self.bounces = bounces
        self.alwaysBounceVertical = alwaysBounceVertical
        self.alwaysBounceHorizontal = alwaysBounceHorizontal
        self.minimumZoomScale = minimumZoomScale
        self.maximumZoomScale = maximumZoomScale
        self.bouncesZoom = bouncesZoom
        self.keyboardDismissMode = keyboardDismissMode

        self.backgroundColor = backgroundColor
    }
}

extension UIScrollView {
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    var visibleRect: CGRect {
        let contentWidth = contentSize.width - contentOffset.x
        let contentHeight = contentSize.height - contentOffset.y
        return CGRect(origin: contentOffset,
                      size: CGSize(width: min(min(bounds.size.width, contentSize.width), contentWidth),
                                   height: min(min(bounds.size.height, contentSize.height), contentHeight)))
    }
}

extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }

    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: -contentInset.left, y: contentOffset.y), animated: animated)
    }

    func scrollToBottom(animated: Bool = true) {
        setContentOffset(
            CGPoint(x: contentOffset.x, y: max(0, contentSize.height - bounds.height) + contentInset.bottom),
            animated: animated)
    }

    func scrollToRight(animated: Bool = true) {
        setContentOffset(
            CGPoint(x: max(0, contentSize.width - bounds.width) + contentInset.right, y: contentOffset.y),
            animated: animated)
    }

    func scrollUp(animated: Bool = true) {
        let minY = -contentInset.top
        var y = max(minY, contentOffset.y - bounds.height)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.height != 0 {
            let page = max(0, ((y + contentInset.top) / bounds.height).rounded(.down))
            y = max(minY, page * bounds.height - contentInset.top)
        }
        #endif
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }

    func scrollLeft(animated: Bool = true) {
        let minX = -contentInset.left
        var x = max(minX, contentOffset.x - bounds.width)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.width != 0 {
            let page = ((x + contentInset.left) / bounds.width).rounded(.down)
            x = max(minX, page * bounds.width - contentInset.left)
        }
        #endif
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }

    func scrollDown(animated: Bool = true) {
        let maxY = max(0, contentSize.height - bounds.height) + contentInset.bottom
        var y = min(maxY, contentOffset.y + bounds.height)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.height != 0 {
            let page = ((y + contentInset.top) / bounds.height).rounded(.down)
            y = min(maxY, page * bounds.height - contentInset.top)
        }
        #endif
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }

    func scrollRight(animated: Bool = true) {
        let maxX = max(0, contentSize.width - bounds.width) + contentInset.right
        var x = min(maxX, contentOffset.x + bounds.width)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.width != 0 {
            let page = ((x + contentInset.left) / bounds.width).rounded(.down)
            x = min(maxX, page * bounds.width - contentInset.left)
        }
        #endif
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }
}
