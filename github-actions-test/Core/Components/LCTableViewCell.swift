//
//  LCTableViewCell.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

public class LCTableViewCell: UITableViewCell {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        contentView.clipsToBounds = false
        contentView.masksToBounds = false
        selectionStyle = .none
    }
}
