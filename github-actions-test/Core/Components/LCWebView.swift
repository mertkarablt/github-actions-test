//
//  LCWebView.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import WebKit

@objc protocol LCWebViewNavigationDelegate: WKNavigationDelegate {
}

@objc public class LCWebView: UIView {
    @objc public var webViewHeightAnchor: NSLayoutConstraint!

    @objc public var isResizableToContent = false {
        didSet {
            webViewHeightAnchor.isActive = isResizableToContent
        }
    }

    @objc public var isScrollEnabled = false {
        didSet {
            self.webView.scrollView.isScrollEnabled = isScrollEnabled
            updatelUserScripts()
        }
    }

    private func updatelUserScripts() {
        if !useDeafultUserScripts { return }
        self.webView.configuration.userContentController.removeAllUserScripts()
        self.webView.configuration.userContentController.addUserScript(viewPortScript())
    }

    @objc public var maximumZoomScale: CGFloat = 1.0 {
        didSet {
            self.webView.scrollView.maximumZoomScale = maximumZoomScale
        }
    }

    @objc public var minimumZoomScale: CGFloat = 1.0 {
        didSet {
            self.webView.scrollView.minimumZoomScale = minimumZoomScale
        }
    }

    @objc public var bouncesZoom = false {
        didSet {
            self.webView.scrollView.bouncesZoom = bouncesZoom
        }
    }

    @objc public var bounces = false {
        didSet {
            self.webView.scrollView.bounces = bounces
        }
    }

    public var scrollView: UIScrollView {
        return webView.scrollView
    }

    @objc weak var navigationDelegate: LCWebViewNavigationDelegate?

    private var webView: WKWebView!

    private var useDeafultUserScripts = false

    @objc public convenience init(useDeafultUserScripts: Bool = false) {
        self.init()
        self.useDeafultUserScripts = useDeafultUserScripts
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    @objc public func load(_ request: URLRequest) {
        self.webView.load(request)
    }

    @objc public func loadData(_ data: Data, type: String) {
        let url = URL.init(string: "")
        guard let webv = self.webView else {
            return
        }
        webv.load(data, mimeType: type, characterEncodingName: "", baseURL: url!)
    }

    @objc public func loadHTMLString(_ htmlString: String, baseURL: URL? = HtmlRequiredConstants.CSSPath) {
        self.webView.loadHTMLString(htmlString, baseURL: baseURL)
    }

    @objc public func goBack() {
        self.webView.goBack()
    }

    @objc public func goForward() {
        self.webView.goForward()
    }

    @objc public func reload() {
        self.webView.reload()
    }

    @objc public func canGoBack() -> Bool {
        return self.webView.canGoBack
    }

    @objc public func canGoForward() -> Bool {
        return self.webView.canGoForward
    }

    @objc public func isLoading() -> Bool {
        return self.webView.isLoading
    }

    @available(iOS 10.0, *)
    @objc public func setDataDetector(type: WKDataDetectorTypes) {
        self.webView.configuration.dataDetectorTypes = type
    }

    private func commonInit() {
        let controller = WKUserContentController()

        if useDeafultUserScripts {
            controller.addUserScript(viewPortScript())
        }

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = controller

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.maximumZoomScale = 1.0
        webView.scrollView.minimumZoomScale = 1.0
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.isOpaque = false
        if self.subviews.count == 0 {
            self.addSubview(webView)
            webView.fillToSuperview()

            webViewHeightAnchor = webView.heightAnchor.constraint(equalToConstant: 0)
            webViewHeightAnchor?.isActive = isResizableToContent

            self.webView = webView
        }
        isScrollEnabled = false
    }

    @objc public func resizeWebViewContainer(completionHandler: @escaping (CGFloat) -> Void) {
        self.webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] result, _ in
            if let height = result as? CGFloat {
                self?.webViewHeightAnchor?.constant = height
                self?.superview?.layoutIfNeeded()
                completionHandler(height)
            }
        })
    }

    private func viewPortScript() -> WKUserScript {
        let viewPortScript = HtmlRequiredConstants.viewPortScript(scrollable: isScrollEnabled)
        return WKUserScript(source: viewPortScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
}

extension LCWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.isLoading == false {
            resizeWebViewContainer { _ in
            }
        }
        self.navigationDelegate?.webView?(webView, didFinish: navigation)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationDelegate != nil {
            if let method = self.navigationDelegate?.webView?(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler) {
                method
            } else {
                decisionHandler(.allow)
            }
            return
        }
        switch navigationAction.navigationType {
        case .linkActivated:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let method = self.navigationDelegate?.webView?(webView, decidePolicyFor: navigationResponse, decisionHandler: decisionHandler) {
            method
        } else {
            decisionHandler(.allow)
        }
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.navigationDelegate?.webView?(webView, didStartProvisionalNavigation: navigation)
    }

    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        self.navigationDelegate?.webView?(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.navigationDelegate?.webView?(webView, didFail: navigation, withError: error)
    }

    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.navigationDelegate?.webView?(webView, didCommit: navigation)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.navigationDelegate?.webView?(webView, didFail: navigation, withError: error)
    }

    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let method = self.navigationDelegate?.webView?(webView, didReceive: challenge, completionHandler: completionHandler) {
            method
        } else {
            completionHandler(.rejectProtectionSpace, nil)
        }
    }

    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        self.navigationDelegate?.webViewWebContentProcessDidTerminate?(webView)
    }
}


open class HtmlRequiredConstants: NSObject {
    public static let CSSPath: URL? = URL(fileURLWithPath: Bundle.main.path(forResource: "style", ofType: "css") ?? "")

    public static let CSSHead = """
                            <head>\
                            <link rel="stylesheet" type="text/css" href="style.css">\
                            </head>
                            """

    public static func viewPortScript(scrollable: Bool = false) -> String {
        let scalable = "user-scalable=\(scrollable ? "yes" : "no")"
        let viewPortScript = """
        var meta = document.createElement('meta');
        meta.setAttribute('name', 'viewport');
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, \(scalable)';
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        return viewPortScript
    }
}
