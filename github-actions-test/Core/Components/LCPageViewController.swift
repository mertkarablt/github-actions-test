//
//  LCPageViewController.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

open class LCPageViewController: UIPageViewController {
    // MARK: Data
    open var pages = [UIViewController]()

    // MARK: Init
    public init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: AnyObject]!) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Public
    open func setViewControllers(viewControllers: [UIViewController], animated: Bool = true, completion: (((Bool) -> Void))? = nil) {
        let initialPage = 0

        for vc in viewControllers {
            self.pages.append(vc)
        }
        setViewControllers([pages[initialPage]], direction: .forward, animated: animated, completion: completion)
    }
}
