//
//  UIViewController+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIViewController {
    var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }

    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if let navigationController = navigationController,
                  navigationController.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if let tabBarController = tabBarController,
                  tabBarController.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}

extension UIViewController {
    class func instantiate(
        from storyboard: String = "Main",
        bundle: Bundle? = nil,
        identifier: String? = nil
    ) -> Self {
        let viewControllerIdentifier = identifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        guard let viewController = storyboard
                .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }

    func addNotificationObserver(
        name: Notification.Name,
        selector: Selector
    ) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    func addChildViewController(
        _ child: UIViewController,
        toContainerView containerView: UIView
    ) {
        child.willMove(toParent: self)
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    #if os(iOS)
    func presentPopover(
        _ popoverContent: UIViewController,
        sourcePoint: CGPoint,
        size: CGSize? = nil,
        delegate: UIPopoverPresentationControllerDelegate? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        popoverContent.modalPresentationStyle = .popover

        if let size = size {
            popoverContent.preferredContentSize = size
        }

        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }

        present(popoverContent, animated: animated, completion: completion)
    }
    #endif
}
