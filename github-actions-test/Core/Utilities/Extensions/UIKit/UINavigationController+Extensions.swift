//
//  UINavigationController+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UINavigationController {
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }

    func pushViewController(
        viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async {
                completion?()
            }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in
            completion?()
        }
    }

    func popViewController(
        animated: Bool,
        completion: (() -> Void)?
    ) {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async {
                completion?()
            }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in
            completion?()
        }
    }

    func popBack(_ count: Int) {
        guard count > 0 else {
            return assertionFailure("Count can not be a negative value.")
        }
        let index = viewControllers.count - count - 1
        guard index > 0 else {
            return assertionFailure("Not enough View Controllers on the navigation stack.")
        }
        popToViewController(viewControllers[index], animated: true)
    }
}
