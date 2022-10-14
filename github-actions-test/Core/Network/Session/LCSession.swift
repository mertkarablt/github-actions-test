//
//  LCSession.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

open class LCSession: Session {
    public convenience init(logEnabled: Bool = false) {
        var eventMonitors: [EventMonitor] = []
        if logEnabled {
            eventMonitors.append(LCNetworkLogger())
        }
        self.init(eventMonitors: eventMonitors)
    }
}
