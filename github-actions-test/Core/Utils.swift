//
//  Utils.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit
import SafariServices

class Utils: NSObject {
    static let shared = Utils()

    func handleURL(
        _ url: String?,
        title: String? = "",
        screenName: String? = nil,
        transition: WebModel.TransitionType = .push,
        type: WebModel.WebViewType = .custom,
        isWebView: Bool = true,
        inheriateWithNavbar: UINavigationController? = nil, /// Added for showing tabBar.
        withCompletion completion: (() -> Void)? = nil
    ) {
//        guard let url = url else { return }
//        if Constants.Deeplink.kDeeplinkPrefixes.first(where: { url.hasPrefix($0) }) != nil {
//            completion?()
//            if let url = URL(string: url) {
//                DeepLinkHandler.shared.handleDeeplinkURL(url: url, inheriateWithNavbar: inheriateWithNavbar, parentCoordinator: parentCoordinator)
//            }
//        } else if url.isValidUrl, (url.hasPrefix("http://") || url.hasPrefix("https://")) {
//            if isWebView {
//                openWebView(
//                    url,
//                    htmlString: nil,
//                    title: title,
//                    transition: transition,
//                    type: type,
//                    isWebView: isWebView,
//                    withCompletion: completion)
//            } else {
//                Utils.shared.openURL(urlString: url, completion: completion)
//            }
//        }
    }

    func openWebView(
        _ url: String? = nil,
        htmlString: String? = nil,
        title: String? = "",
        screenName: String? = nil,
        transition: WebModel.TransitionType = .push,
        type: WebModel.WebViewType = .custom,
        isWebView: Bool = true,
        withCompletion completion: (() -> Void)? = nil
    ) {
        guard let url = url else {
            completion?()
            return
        }

        if type == .system {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = false
            config.barCollapsingEnabled = true

            let vc = SFSafariViewController(url: url.url!, configuration: config)
            vc.dismissButtonStyle = .close
            vc.preferredBarTintColor = UIColor(rgbaValue: 0xfafafacc)
            vc.preferredControlTintColor = .gray
            vc.modalPresentationStyle = .fullScreen

            if transition == .present {
                UIApplication.topViewController()?.present(
                    vc,
                    animated: true,
                    completion: completion
                )
            } else {
                UIApplication.topViewController()?.navigationController?.pushViewController(
                    viewController: vc,
                    animated: true,
                    completion: completion
                )
            }
        } else {

        }
    }

    func openURL(
        urlString: String,
        completion: (() -> Void)? = nil
    ) {
        guard let url = URL(string: urlString) else {
            completion?()
            return
        }
        openURL(url: url, completion: completion)
    }

    func openURL(
        url: URL,
        completion: (() -> Void)? = nil
    ) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url,
                                      options: [:]) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}
