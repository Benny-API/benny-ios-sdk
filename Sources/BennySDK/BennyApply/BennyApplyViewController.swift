//
//  BennyApplyViewController.swift
//
//
//  Created by Ariel Bong on 11/8/23.
//

import SwiftUI
import UIKit
import WebKit

private var bennyApplyProductionURL = "https://apply.bennyapi.com"
private var bennyApplyStagingURL = "https://apply-staging.bennyapi.com"

public class BennyApplyViewController: UIViewController, WKNavigationDelegate {
    var organizationId: String
    var externalId: String
    var webViewVM: BaseWebViewVM
    var bennyView: WKWebView
    var delegate: BennyApplyListenerDelegate?

    public init(parameters: BennyApplyParameters, delegate: BennyApplyListenerDelegate?) {
        var webResource: String
        var baseUrl: String
        switch parameters.environment {
        case Environment.STAGING:
            baseUrl = bennyApplyStagingURL
        case Environment.PRODUCTION:
            baseUrl = bennyApplyProductionURL
        default:
            baseUrl = bennyApplyProductionURL
        }
        webResource = baseUrl + "/?organizationId=" + parameters.organizationId + "&externalId=" + parameters.externalId + "&isWebView=true"
        self.organizationId = parameters.organizationId
        self.externalId = parameters.externalId
        self.webViewVM = BaseWebViewVM(webResource: webResource)
        self.bennyView = webViewVM.webView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    // Required initializer when subclassing UIViewController
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        webViewVM.loadWebPage()
        view = bennyView
        bennyView.navigationDelegate = self
    }

    public func webView(_: WKWebView, didFinish _: WKNavigation!) {
        _ = BennyApplyListener(webView: bennyView, delegate: delegate)
    }
}

public struct BennyApplyViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewType = WKWebView
    var orgId: String
    var externalId: String
    var viewController: BennyApplyViewController

    public init(parameters: BennyApplyParameters, delegate: BennyApplyListenerDelegate?) {
        self.orgId = parameters.organizationId
        self.externalId = parameters.externalId
        self.viewController = BennyApplyViewController(parameters: parameters, delegate: delegate)
    }

    public func makeUIViewController(context _: Context) -> UIViewController {
        return viewController
    }

    // Created to conform to protocol
    public func updateUIViewController(_: UIViewController, context _: Context) {}
}
