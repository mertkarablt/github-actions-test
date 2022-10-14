//
//  AppDelegate+Initialize.swift
//  kapida
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit
import Kingfisher
import IQKeyboardManagerSwift

extension AppDelegate {
    func commonInit(
        _ application: UIApplication
    ) {
        BaseURLChanger.shared.initialize()

        initializeLogSystem()
        initializeFirebase()
        registerForPushNotifications(application)
        initializeImageCache()
        initializeIQKeyboardManager()
        initializeGadget()
    }

    private func initializeLogSystem() {
        #if DEBUG
        LCLogger.configure(logLevel: .debug)
        #else
        LCLogger.configure(logLevel: .none)
        #endif
        log("\(Bundle.main.applicationName) - v\(Bundle.main.appShortVersion) Build:\(Bundle.main.appVersion)")
    }

    private func initializeFirebase() {
        FirebaseConfigurator.start()
    }

    private func initializeImageCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.expiration = .seconds(600)
        cache.diskStorage.config.expiration = .days(3)
        cache.cleanExpiredMemoryCache()
        cache.cleanExpiredDiskCache()
    }

    private func initializeIQKeyboardManager() {
        let iqKeyboardManager = IQKeyboardManager.shared
        iqKeyboardManager.enable = true
        iqKeyboardManager.keyboardDistanceFromTextField = 20.0
        iqKeyboardManager.enableAutoToolbar = false
        iqKeyboardManager.shouldResignOnTouchOutside = true
    }

    func initializeGadget() {
        #if GADGET
        initializeGadget(true)
        #endif
    }
}
