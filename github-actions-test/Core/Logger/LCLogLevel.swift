//
//  LCLogLevel.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

/// Define log level
public enum LCLogLevel: Int, Comparable {
    /// No logs - default
    case none = 0
    /// Error logs only
    case error = 1
    /// Enable success logs
    case success = 2
    /// Enable warning logs
    case warning = 3
    /// Enable info logs
    case info = 4
    /// Enable all logs
    case debug = 5

    func toString() -> String {
        switch self {
        case .none:
            return ""
        case .error:
            return "🔴"
        case .success:
            return "🟢"
        case .warning:
            return "🟠"
        case .info:
            return "🔵"
        case .debug:
            return "🚀"
        }
    }

    public static func < (lhs: LCLogLevel, rhs: LCLogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    static func all() -> [LCLogLevel] {
        return [.none, .error, .success, .warning, .info, .debug]
    }
}
