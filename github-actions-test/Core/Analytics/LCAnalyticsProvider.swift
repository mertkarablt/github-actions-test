//
//  LCAnalyticsProvider.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

public protocol LCAnalyticsProvider {
    var identifier: String { get set }
    func track(event: String, parameters: [String: Any]?)
}
