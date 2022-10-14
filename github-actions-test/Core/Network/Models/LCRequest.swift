//
//  LCRequest.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

public struct LCRequest: LCRouterProtocol {
    public var baseURL: URL
    public var path: String?
    public var method: HTTPMethod
    public var headers: HTTPHeaders
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    public var timeout: TimeInterval = 60.0
    public var task: LCHTTPTask
}
