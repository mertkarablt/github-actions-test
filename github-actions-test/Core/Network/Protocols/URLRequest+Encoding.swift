//
//  LCNetworkRequestProtocol.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

internal extension URLRequest {
    mutating func encoded(encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest {
        do {
            let encodable = AnyEncodable(encodable)
            httpBody = try encoder.encode(encodable)

            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

            return self
        } catch {
            throw LCNetworkError.encoding
        }
    }

    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw LCNetworkError.encoding
        }
    }
}
