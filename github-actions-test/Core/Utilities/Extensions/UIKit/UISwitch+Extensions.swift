//
//  UISwitch+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension UISwitch {
    func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }
}
