//
//  LCCollectionViewCell.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

open class LCCollectionViewCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .clear
        clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.masksToBounds = false
    }
}

// MARK: - Reuse
extension LCCollectionViewCell: Reusable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension LCCollectionViewCell: NibLoadable {
    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
