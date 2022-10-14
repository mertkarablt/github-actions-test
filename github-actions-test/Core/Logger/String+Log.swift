//
//  String+Log.swift
//  kapida
//
//  Created by Ünal Öztürk on 21.07.2022.
//

import Foundation

extension String {
    // https://en.wikipedia.org/wiki/Printf_format_string
    private static var formatCharacters: Set<Character> {
        "@diufFeEgGxXoscpaAn".reduce(into: []) { $0.insert($1) }
    }

    internal static func safely(format template: String, _ params: CVarArg...) -> String {
        var potentialPattern = false
        var patternCount = 0
        for char in template {
            switch char {
            case "%":
                // %% or %
                potentialPattern.toggle()
            case let x where formatCharacters.contains(x) && potentialPattern:
                patternCount += 1
                potentialPattern = false
            case let x where !x.isWhitespace:
                potentialPattern = false
            default:
                break
            }
        }
//        assert(
//            patternCount <= params.count,
//            "Not enough parameters passed to format String. Found \(params.count), expected at least \(patternCount)."
//        )
        return String(format: template, arguments: params)
    }
}
