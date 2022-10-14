//
//  Bundle+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

private enum Keys {
    static let shortVersion = "CFBundleShortVersionString"
    static let version = "CFBundleVersion"
    static let executable = "CFBundleExecutable"
}

private enum Const {
    static let unknown = "Unknown"
}

extension Bundle {
    public var appShortVersion: String {
        return object(forInfoDictionaryKey: Keys.shortVersion) as? String ?? Const.unknown
    }

    public var appVersion: String {
        return object(forInfoDictionaryKey: Keys.version) as? String ?? Const.unknown
    }

    public var applicationName: String {
        return object(forInfoDictionaryKey: Keys.executable) as? String ?? Const.unknown
    }
}
