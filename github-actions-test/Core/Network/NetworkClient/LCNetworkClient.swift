//
//  LCNetworkClient.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

open class LCNetworkClient: LCNetworkClientProtocol {
    public var session: LCSession

    public init(session: LCSession = LCSession()) {
        self.session = session
    }
}
