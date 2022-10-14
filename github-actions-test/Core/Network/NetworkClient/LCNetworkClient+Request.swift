//
//  LCNetworkClient+Request.swift
//  LCore
//
//  Created by Mert Karabulut on 10.05.2021.
//

import Foundation

import Alamofire

extension LCNetworkClient {
    @discardableResult
    open func request<R: LCRouterProtocol, T: Decodable>(
        router: R,
        model: T.Type,
        completion: @escaping LCNetworkCompletion<T>
    ) -> Request {
        switch router.task {
        case .requestPlain,
             .requestData,
             .requestJSONEncodable,
             .requestCustomJSONEncodable,
             .requestParameters,
             .requestCompositeData,
             .requestCompositeParameters:
            let request = session.request(router, interceptor: nil)
            let validatedRequest = request.validate()

            validatedRequest.responseDecodable(of: T.self) { responseData in
                switch responseData.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    self.handle(error: error, responseData: responseData, completion: completion)
                }
            }

            return validatedRequest
        default:
            fatalError("\(router.task) is not a request task.")
        }
    }
}
