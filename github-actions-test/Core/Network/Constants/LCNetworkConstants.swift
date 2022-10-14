//
//  LCNetworkConstants.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

public struct LCNetworkConstants {
    /// The keys for HTTP header fields
    public enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    /// The values for HTTP header fields
    public enum HTTPHeaderFieldValue: String {
        case json = "application/json"
        case fromEncoded = "application/x-www-form-urlencoded"
    }
}
