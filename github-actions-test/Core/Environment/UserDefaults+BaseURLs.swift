//
//  UserDefaults+BaseURLs.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let serviceEnv = LCBaseServiceType.serviceEnv.rawValue
        static let masterpassEnv = LCBaseServiceType.masterpassEnv.rawValue
        static let personaClickEnv = LCBaseServiceType.personaClickEnv.rawValue
    }

    public var serviceEnvValue: String {
        get {
            return string(forKey: Keys.serviceEnv) ?? ""
        }
        set {
            set(newValue, forKey: Keys.serviceEnv)
        }
    }

    public var masterpassEnvValue: String {
        get {
            return string(forKey: Keys.masterpassEnv) ?? ""
        }
        set {
            set(newValue, forKey: Keys.masterpassEnv)
        }
    }

    public var personaClickEnvValue: String {
        get {
            return string(forKey: Keys.personaClickEnv) ?? ""
        }
        set {
            set(newValue, forKey: Keys.personaClickEnv)
        }
    }
}
