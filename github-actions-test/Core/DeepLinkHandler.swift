//
//  DeepLinkHandler.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import DeepLinkKit

class DeepLinkHandler {
    static let shared = DeepLinkHandler()

    lazy var router = DPLDeepLinkRouter()
    var isAppReady = false

    var cachedURL: URL?
    var cachedHomeURL: URL?
    var cachedUserActivity: NSUserActivity?

    func clearCache() {
        cachedURL = nil
        cachedHomeURL = nil
    }

    func appIsReady() {
        registerRoutes()
        isAppReady = true
        handle()
    }

    func handle() {
        if isAppReady {
            if let url = cachedURL {
                cachedHomeURL = url
                router.handle(url, withCompletion: { _, _ in
                    self.isAppReady = false
                })
                self.cachedURL = nil
            } else if let activity = cachedUserActivity {
                router.handle(activity, withCompletion: { _, _ in
                    self.isAppReady = false
                })
                cachedUserActivity = nil
            }
        }
    }

    func registerRoutes() {
//        router.register(Constants.Deeplink.URLs.home) { link in
//            self.handlePageName(url: link?.url)
//        }
//        router.register(Constants.Deeplink.URLs.prefix) { link in
//            self.handlePageName(url: link?.url)
//        }
//        router.register(Constants.Deeplink.URLs.deeplinkBase) { link in
//            self.handlePageName(url: link?.url)
//        }
//        router.register("a101kapida://") { link in
//            self.handlePageName(url: link?.url)
//        }
    }

    func registerURL(string: String, completion: (() -> Void)? = nil) {
        router.register(string) { link in
            guard let url = link?.url.absoluteString else { return }
            Utils.shared.handleURL(url, isWebView: true, withCompletion: completion)
        }
    }
}


fileprivate extension String {
    var deeplinkPageURLString: String? {
        get {
            return deeplinkPageURL?.absoluteString
        }
    }

    var deeplinkPageURL: URL? {
        get {
            guard var url = URL(string: "") else { return nil }
            url.appendQueryParameters(["pageName": self])
            return url
        }
    }
}
