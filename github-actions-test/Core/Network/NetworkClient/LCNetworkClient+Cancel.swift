//
//  LCNetworkClient+Cancel.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

extension LCNetworkClient {
    open func cancel(request: Request, completion: (() -> Void)?) {
        session.withAllRequests { requests in
            requests.forEach { sessionRequest in
                if sessionRequest.request == request.request {
                    sessionRequest.cancel()
                }
            }
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
