//
//  AppDelegate+Route.swift
//  kapida
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit
import FirebaseDynamicLinks

extension AppDelegate {
    @available(iOS 9.0, *)
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        let intentedForFirebase = application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: ""
        )

        guard !intentedForFirebase else { return true }

        return false
    }

    func application(
        _ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any
    ) -> Bool {
//        if url.scheme == Constants.Deeplink.scheme {
//            handleDeepLink(url)
//            return true
//        }
//
//        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
//            handleURLDynamicLink(dynamicLink)
//            return true
//        }

        return false
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        if let url = userActivity.webpageURL {
            var urlHandled = DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
                guard error == nil else { return }
                if let dynamicLink = dynamicLink {
                    self.handleURLDynamicLink(dynamicLink)
                }
            }

            if !urlHandled {
                handleWebPage(url)
                urlHandled = true
            }

            return urlHandled
        }
        return false
    }

    // MARK: Shortcut
    func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        guard let userInfo = shortcutItem.userInfo else { return }
        handleDeeplinkPush(userInfo)
    }
}


// MARK: Deeplink
extension AppDelegate {
    func handleDeeplinkPush(_ userInfo: [AnyHashable: Any]) {
        if let urlString = userInfo["deeplink"] as? String,
           let url = URL(string: urlString) {
            handleDeepLink(url)
        }
    }

    private func handleURLDynamicLink(_ dynamicLink: DynamicLink) {
        guard let url = dynamicLink.url else { return }
        handleDeepLink(url)
    }

    func handleDeepLink(_ url: URL) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            DeepLinkHandler.shared.cachedHomeURL = url
//            DeepLinkHandler.shared.cachedURL = url
//            if Constants.Deeplink.kDeeplinkPrefixes.first(where: { url.absoluteString.hasPrefix($0) }) == nil {
//                DeepLinkHandler.shared.registerURL(string: url.absoluteString)
//            }
//            DeepLinkHandler.shared.router.handle(url, withCompletion: nil)
//        }
    }

    func handleWebPage(_ url: URL?) {
//        guard let newUrl = url?.setScheme(Constants.Deeplink.scheme) else { return }
//        handleDeepLink(newUrl)
    }
}
