//
//  LCNetworkClientProtocol.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

public typealias LCNetworkCompletion<T: Decodable> = (Result<T, LCNetworkError>) -> Void
public typealias LCNetworkDownloadCompletion = (URL?, URLResponse?, LCNetworkError?) -> Void

public protocol LCNetworkClientProtocol {
    var session: LCSession { get }

    @discardableResult
    func request<R: LCRouterProtocol, T: Decodable>(
        router: R,
        model: T.Type,
        completion: @escaping LCNetworkCompletion<T>
    ) -> Request

    @discardableResult
    func upload<R: LCRouterProtocol, T: Decodable>(
        router: R,
        file: URL,
        model: T.Type,
        progress: Alamofire.Request.ProgressHandler?,
        completion: @escaping LCNetworkCompletion<T>
    ) -> Request

    @discardableResult
    func download<R: LCRouterProtocol>(
        router: R,
        destination: Alamofire.DownloadRequest.Destination,
        progress: Request.ProgressHandler?,
        completion: @escaping LCNetworkDownloadCompletion
    ) -> Request

    func cancel(
        request: Request,
        completion: (() -> Void)?
    )
}
