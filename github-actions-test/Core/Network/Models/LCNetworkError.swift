//
//  LCNetworkError.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

public enum LCNetworkError: Error {
    case decoding
    case encoding
    case missingURL
    case badRequest(_ data: Data?)
    case auth
    case forbidden
    case notFound
    case invalidMethod
    case timeout
    case requestCancelled
    case noInternetConnection
    case unknown
    case error(AFError)
}
