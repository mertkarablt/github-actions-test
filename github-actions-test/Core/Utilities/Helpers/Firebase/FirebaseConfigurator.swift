//
//  FirebaseConfigurator.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Firebase
import FirebaseAnalytics

public class FirebaseConfigurator {
    public class func start() {
        #if !CONF_STORE
        var args = ProcessInfo.processInfo.arguments
        args.append("-FIRAnalyticsDebugEnabled")
        args.append("-FIRDebugEnabled")
        ProcessInfo.processInfo.setValue(args, forKey: "arguments")
        #endif

        FirebaseApp.configure()

        let analyticsProvider = FirebaseAnalyticsProvider()
        LCAnalyticsManager.add([analyticsProvider])
    }
}
