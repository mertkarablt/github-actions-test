//
//  LCTableView.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

open class LCTableView: UITableView {
    // MARK: Init
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        prepare()
    }
}
