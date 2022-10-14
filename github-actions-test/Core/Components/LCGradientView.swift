//
//  LCGradientView.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

public class LCGradientView: UIView {
    // MARK: Data
    var startPoint: CAGradientLayer.Point = .bottom {
        didSet {
            refresh()
        }
    }
    var endPoint: CAGradientLayer.Point = .top {
        didSet {
            refresh()
        }
    }
    var colors: [UIColor] = [
        UIColor.white.withAlphaComponent(0.8),
        UIColor.white.withAlphaComponent(0.63),
        UIColor.white.withAlphaComponent(0.0)
    ] {
        didSet {
            refresh()
        }
    }
    var locations: [Double] = [0.0, 0.57, 1] {
        didSet {
            refresh()
        }
    }

    init(
        startPoint: CAGradientLayer.Point,
        endPoint: CAGradientLayer.Point
    ) {
        super.init(frame: .zero)
        refresh()
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        refresh()
    }

    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    public var gradientLayer: CAGradientLayer {
        get { return self.layer as! CAGradientLayer }
    }

    private func refresh() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.locations = locations.map({ NSNumber(value: $0) })
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            let isVisible = !subview.isHidden
            let isUserInteractionEnabled = subview.isUserInteractionEnabled
            let isPointInside = subview.point(inside: convert(point, to: subview), with: event)
            if isVisible &&
                isUserInteractionEnabled &&
                isPointInside {
                return true
            }
        }
        return false
    }
}

extension CAGradientLayer {
    enum Point {
        case top, topRight, topLeft
        case bottom, bottomRight, bottomLeft
        case left, right
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
            case .top: return CGPoint(x: 0.5, y: 0)
            case .topRight: return CGPoint(x: 1, y: 0)
            case .topLeft: return CGPoint(x: 0, y: 0)
            case .bottom: return CGPoint(x: 0.5, y: 1)
            case .bottomRight: return CGPoint(x: 1, y: 1)
            case .bottomLeft: return CGPoint(x: 0, y: 1)
            case .left: return CGPoint(x: 0, y: 0.5)
            case .right: return CGPoint(x: 1, y: 0.5)
            case .custom(let point): return point
            }
        }
    }
}
