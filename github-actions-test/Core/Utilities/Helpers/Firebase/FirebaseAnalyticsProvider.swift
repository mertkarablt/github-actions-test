//
//  FirebaseAnalyticsProvider.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Firebase

public class FirebaseAnalyticsProvider: NSObject, LCAnalyticsProvider {
    public var identifier: String

    // MARK: Init
    public init(indentifier: String = "firebase") {
        Analytics.setAnalyticsCollectionEnabled(true)

        self.identifier = indentifier
        super.init()
    }

    // MARK: Track
    public func track(
        event: String,
        parameters: [String: Any]?
    ) {
        Analytics.logEvent(event, parameters: parameters)
    }
}
