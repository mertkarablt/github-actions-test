//
//  OAuthCredential.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

public struct OAuthCredential: AuthenticationCredential, Codable {
    public let accessToken: String
    public let refreshToken: String
    public let userID: String
    public let expiration: Date

    public var requiresRefresh: Bool {
        return Date().isGreaterThan(expiration)
    }
}
