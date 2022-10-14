//
//  CGFloat+Extensions.swift
//  LCore
//
//  Created by Muhammed Karakul on 16.02.2021.
//

import UIKit

extension CGFloat {
    public static var screenBounds: CGRect {
        UIScreen.main.bounds
    }

    public static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    public static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    public static var random: CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
