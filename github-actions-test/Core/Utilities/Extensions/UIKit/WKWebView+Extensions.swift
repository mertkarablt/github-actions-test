//
//  WKWebView+Extensions.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import WebKit

// MARK: - Methods
extension WKWebView {
    @discardableResult
    public func loadURL(_ url: URL) -> WKNavigation? {
        return load(URLRequest(url: url))
    }

    @discardableResult
    public func loadURLString(_ urlString: String) -> WKNavigation? {
        guard let url = URL(string: urlString) else { return nil }
        return load(URLRequest(url: url))
    }
}
