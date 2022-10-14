//
//  CGSize+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import CoreGraphics

extension CGSize {
    var aspectRatio: CGFloat {
        guard height != 0 else { return 0 }
        return width / height
    }

    var maxDimension: CGFloat {
        return max(width, height)
    }

    var minDimension: CGFloat {
        return min(width, height)
    }

    func aspectFit(to boundingSize: CGSize) -> CGSize {
        let minRatio = min(boundingSize.width / width, boundingSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }

    func aspectFill(to boundingSize: CGSize) -> CGSize {
        let minRatio = max(boundingSize.width / width, boundingSize.height / height)
        let aWidth = min(width * minRatio, boundingSize.width)
        let aHeight = min(height * minRatio, boundingSize.height)
        return CGSize(width: aWidth, height: aHeight)
    }
}
