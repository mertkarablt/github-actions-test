//
//  UITableView+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UITableView {
    convenience init(
        style: Style = .plain,
        cells: [LCTableViewCell.Type],
        allowsSelection: Bool = true,
        allowsMultipleSelection: Bool = false,
        isPagingEnabled: Bool = false,
        isScrollEnabled: Bool = true,
        showsVerticalScrollIndicator: Bool = true,
        separatorStyle: UITableViewCell.SeparatorStyle = .singleLine,
        separatorColor: UIColor? = .gray,
        separatorInset: UIEdgeInsets = .zero,
        scrollIndicatorInsets: UIEdgeInsets = .zero,
        bounces: Bool = true,
        tableHeaderView: UIView? = nil,
        tableFooterView: UIView? = nil,
        backgroundColor: UIColor? = .white) {
        self.init(frame: .zero, style: style)

        prepare(allowsSelection: allowsSelection,
                allowsMultipleSelection: allowsMultipleSelection,
                isPagingEnabled: isPagingEnabled,
                isScrollEnabled: isScrollEnabled,
                showsVerticalScrollIndicator: showsVerticalScrollIndicator,
                separatorStyle: separatorStyle,
                separatorColor: separatorColor,
                separatorInset: separatorInset,
                scrollIndicatorInsets: scrollIndicatorInsets,
                bounces: bounces,
                tableHeaderView: tableHeaderView,
                tableFooterView: tableFooterView,
                backgroundColor: backgroundColor
        )
    }

    func prepare(allowsSelection: Bool = true,
        allowsMultipleSelection: Bool = false,
        isPagingEnabled: Bool = false,
        isScrollEnabled: Bool = true,
        showsVerticalScrollIndicator: Bool = true,
        separatorStyle: UITableViewCell.SeparatorStyle = .none,
        separatorColor: UIColor? = .gray,
        separatorInset: UIEdgeInsets = .zero,
        scrollIndicatorInsets: UIEdgeInsets = .zero,
        bounces: Bool = true,
        tableHeaderView: UIView? = nil,
        tableFooterView: UIView? = nil,
        backgroundColor: UIColor? = .clear
    ) {
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelection = allowsMultipleSelection
        self.isPagingEnabled = isPagingEnabled
        self.isScrollEnabled = isScrollEnabled
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.separatorStyle = separatorStyle
        self.separatorColor = separatorColor
        self.separatorInset = separatorInset
        self.scrollIndicatorInsets = scrollIndicatorInsets
        self.bounces = bounces

        if let header = tableHeaderView {
            self.tableHeaderView = header
        }

        if let footer = tableFooterView {
            self.tableFooterView = footer
        }

        self.backgroundColor = backgroundColor
    }
}

extension UITableView {
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return indexPathForLastRow(inSection: lastSection)
    }

    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
}

extension UITableView {
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }

    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0 else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }

    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    func fixCellBounds() {
        DispatchQueue.main.async { [weak self] in
            for cell in self?.visibleCells ?? [] {
                cell.layer.masksToBounds = false
                cell.contentView.layer.masksToBounds = false
            }
        }
    }

    func removeTableFooterView() {
        tableFooterView = nil
    }

    func removeTableHeaderView() {
        tableHeaderView = nil
    }

    func isCellVisible(indexPath: IndexPath) -> Bool {
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains(indexPath)
    }

    func isCellVisible(indexPath: IndexPath, for frame: CGRect) -> Bool {
        guard let indexes = self.indexPathsForRows(in: frame) else {
            return false
        }
        return indexes.contains(indexPath)
    }

    func sizeHeaderToFit(preferredWidth: CGFloat) {
        guard let headerView = self.tableHeaderView else {
            return
        }

        headerView.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(
            item: headerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: preferredWidth)

        headerView.addConstraint(layout)

        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        headerView.frame = CGRect(x: 0, y: 0, width: preferredWidth, height: height)

        headerView.removeConstraint(layout)
        headerView.translatesAutoresizingMaskIntoConstraints = true

        self.tableHeaderView = headerView
    }

    func sizeFooterToFit(preferredWidth: CGFloat) {
        guard let footerView = self.tableFooterView else {
            return
        }

        footerView.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(
            item: footerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: preferredWidth)

        footerView.addConstraint(layout)

        let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        footerView.frame = CGRect(x: 0, y: 0, width: preferredWidth, height: height)

        footerView.removeConstraint(layout)
        footerView.translatesAutoresizingMaskIntoConstraints = true

        self.tableFooterView = footerView
    }

    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.row >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    func safeScrollToRow(
        at indexPath: IndexPath,
        at scrollPosition: UITableView.ScrollPosition,
        animated: Bool
    ) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}


extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError(
                "Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }

    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    func register(cellsWithClasses cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(cellWithClass: cell)
        }
    }

    func register(nibsWithCellClasses cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(nibWithCellClass: cell)
        }
    }
}
