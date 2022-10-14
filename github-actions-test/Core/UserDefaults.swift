//
//  UserDefaults.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension UserDefaults {
    public var isSystemNotificationSettingsGranted: Bool {
        get {
            return bool(forKey: "isSystemNotificationSettingsGranted")
        }
        set {
            set(newValue, forKey: "isSystemNotificationSettingsGranted")
        }
    }
}
