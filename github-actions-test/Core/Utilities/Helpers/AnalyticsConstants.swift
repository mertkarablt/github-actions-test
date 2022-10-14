//
//  AnalyticsConstants.swift
//  LCore
//
//  Created by Mert Karabulut on 18.01.2022.
//

import Foundation

public struct AnalyticsEvent: Equatable, Hashable {
    public static let screenView: String = "screen_view"
}

public struct AnalyticsParameter: Equatable, Hashable {
    public static let screenName: String = "screen_name"
    public static let screenClass: String = "screen_class"
}
