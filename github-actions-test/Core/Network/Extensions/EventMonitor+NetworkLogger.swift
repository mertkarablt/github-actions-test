//
//  LCNetworkLogger.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

final class LCNetworkLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let headers = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let url = request.request.flatMap { $0.url?.absoluteString } ?? "None"
        let method = request.request.flatMap { $0.httpMethod } ?? "None"
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let path = request.request.flatMap { $0.url?.path } ?? "None"
        let parameters = request.request.flatMap { $0.url?.queryParameters?.jsonString(prettify: true) } ?? "None"
        let logString = """
        🌩 ↗️ Request Started
        🌩 ↗️ Request: (\(method)) \(url)
        🌩 ↗️ Path: \(path)
        🌩 ↗️ Parameters: \(parameters)
        🌩 ↗️ Body: \(body)
        🌩 ↗️ Headers: \(headers)
        """

        log(logString)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        let headers = response.response?.allHeaderFields.jsonString(prettify: true) ?? "None"
        let url = request.request.flatMap { $0.url?.absoluteString } ?? "None"
        let method = request.request.flatMap { $0.httpMethod } ?? "None"
        let statusCode = response.response?.statusCode.string ?? "None"
        let logString = """
        🌩 ↘️ Response Received
        🌩 ↘️ Response: (\(statusCode)) [(\(method))] \(url)
        🌩 ↘️ Headers: \(headers)
        🌩 ↘️ Received: \(response.debugDescription)
        🌩 ↘️ Data: \(String(describing: response.data?.prettyPrintedJSONString))
        """

        log(logString)
    }
}
