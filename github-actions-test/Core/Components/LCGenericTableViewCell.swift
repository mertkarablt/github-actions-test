//
//  LCGenericTableViewCell.swift
//  LCore
//
//  Created by Mert Karabulut on 11.05.2021.
//

import UIKit

open class LCGenericTableViewCell<View: UIView>: UITableViewCell {
    // MARK: UI
    open var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setupViews()
        }
    }

    open var top: NSLayoutConstraint!
    open var leading: NSLayoutConstraint!
    open var trailing: NSLayoutConstraint!
    open var bottom: NSLayoutConstraint!

    open var insets: UIEdgeInsets = .zero {
        didSet {
            guard let _ = cellView else { return }
            if top.constant != insets.top {
                top.constant = insets.top
            }
            if leading.constant != insets.left {
                leading.constant = insets.left
            }
            if trailing.constant != -insets.right {
                trailing.constant = -insets.right
            }
            if bottom.constant != -insets.bottom {
                bottom.constant = -insets.bottom
            }
        }
    }

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setupViews() {
        guard let cellView = cellView else { return }

        contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false

        leading = cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        trailing = cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        top = cellView.topAnchor.constraint(equalTo: contentView.topAnchor)
        bottom = cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        NSLayoutConstraint.activate([leading, trailing, top, bottom])

        backgroundColor = .clear
        contentView.clipsToBounds = false
        contentView.masksToBounds = false
        selectionStyle = .none
    }
}
