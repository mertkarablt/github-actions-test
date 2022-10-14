//
//  FirebaseAnalyticsTrackable.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

protocol FirebaseAnalyticsTrackable {
    func track(
        event: String,
        parameters: [String: Any?]?,
        completion: (() -> Void)?
    )
}

extension FirebaseAnalyticsTrackable {
    func track(
        event: String,
        parameters: [String: Any?]? = nil,
        completion: (() -> Void)? = nil
    ) {
        let params = parameters?.compactMapValues { $0 }
        LCAnalyticsManager.track(
            event: event,
            parameters: params?.compactMapKeysAndValues({
                ($0.key, $0.value)
            }),
            completion: completion
        )
    }
}
