//
//  LCLogger.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation

public func log_debug(
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...) {
    LCLogger.log(function: function, line: line, logLevel: .debug, message: message, arguments: arguments)
}

public func log_error(
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...) {
    LCLogger.log(function: function, line: line, logLevel: .error, message: message, arguments: arguments)
}

public func log_success(
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...) {
    LCLogger.log(function: function, line: line, logLevel: .success, message: message, arguments: arguments)
}

public func log_warning(
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...) {
    LCLogger.log(function: function, line: line, logLevel: .warning, message: message, arguments: arguments)
}

public func log_info(
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...) {
    LCLogger.log(function: function, line: line, logLevel: .info, message: message, arguments: arguments)
}

public func log(
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...) {
    LCLogger.log(function: function, line: line, logLevel: .debug, message: message, arguments: arguments)
}

@objc public class LCLogger: NSObject {
    internal static let shared = LCLogger()
    internal var logLevel: LCLogLevel = .none

    public class func configure(logLevel: LCLogLevel) {
        let logger = LCLogger.shared
        logger.logLevel = logLevel
    }

    internal static func log(
        function: String,
        line: Int,
        logLevel: LCLogLevel,
        message: String,
        arguments: CVarArg...
    ) {
        if LCLogger.shared.logLevel == .none {
            return
        }

        let dateStr = DateFormatter.logEntryDateFormatter.string(from: Date())
        let logMessage = String.safely(format: message, arguments)
        let message = """

        \(logLevel.toString()) - [\(dateStr)] - func \(function) - Line: \(line)
        \(logMessage)
        """
        print(message)
    }
}
