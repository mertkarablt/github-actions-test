//
//  LCNetworkClient+Handle.swift
//  LCore
//
//  Created by Mert Karabulut on 10.05.2021.
//

import Foundation
import Alamofire

extension LCNetworkClient {
    func handle<T: Decodable>(
        error: AFError,
        responseData: AFDataResponse<T>,
        completion: @escaping LCNetworkCompletion<T>
    ) {
        switch responseData.response?.statusCode {
        case 400: // Bad Request
            completion(.failure(.badRequest(responseData.data)))
        case 401: // Authorization
            completion(.failure(.auth))
        case 403: // Forbidden
            completion(.failure(.forbidden))
        case 404: // Not Found
            completion(.failure(.notFound))
        case 405: // Invalid Method
            completion(.failure(.invalidMethod))
        case 408, 500: // Timeout
            completion(.failure(.timeout))
        case 499:
            completion(.failure(.requestCancelled))
        default:
            guard NetworkReachabilityManager()?.isReachable ?? false else {
                completion(.failure(.noInternetConnection))
                return
            }

            completion(.failure(.error(error)))
        }
    }
}
