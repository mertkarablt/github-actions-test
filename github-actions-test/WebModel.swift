//
//  WebModel.swift
//  kapida
//
//  Created by Mert Karabulut on 19.02.2022.
//

import Foundation

public struct WebModel: Codable {
    public enum TransitionType: String, Codable {
        case push
        case present
    }

    public enum WebViewType: String, Codable {
        case system
        case custom
    }

    public let title: String?
    public let screenName: String?
    public let url: String?
    public let htmlString: String?
    public let transition: TransitionType
    public let type: WebViewType

    public init(
        title: String? = nil,
        screenName: String? = nil,
        url: String? = nil,
        htmlString: String? = nil,
        transition: TransitionType,
        type: WebViewType = .custom
    ) {
        self.title = title
        self.screenName = screenName
        self.url = url
        self.htmlString = htmlString
        self.transition = transition
        self.type = type
    }
}
