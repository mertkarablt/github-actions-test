//
//  LCEnvironment.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

@objc public class LCEnvironment: NSObject {
    @objc static public var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
