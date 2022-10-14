//
//  UIViewController+Instance.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UIViewController {
    public class func instance<T: UIViewController>(
        from storyboardName: String,
        with identifier: String = String("\(T.self)"),
        bundle: Bundle? = nil
    ) -> T {
        // if storyboard with storyboardName doesn't exist or bundle doesn't contain storyboard then init
        // of UIStoryboard will throw NSException
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let storyboardVC = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            print("Can't init \(T.self) with \(storyboardName):\(identifier) using \(T.self)()")
            return T()
        }
        return storyboardVC
    }
}
