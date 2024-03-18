//
//  EbtBalanceViewController.swift
//
//
//  Created by Ariel Bong on 3/18/24.
//

import SwiftUI
import UIKit
import WebKit

private var ebtBalanceProductionURL = "https://ebtbalance.bennyapi.com"
private var ebtBalanceSandboxURL = "https://ebtbalance-sandbox.bennyapi.com"

public class EbtBalanceViewController: UIViewController, WKNavigationDelegate {
    var organizationId: String
    var webViewVM: BaseWebViewVM
    var bennyView: WKWebView
    var delegate: EbtBalanceListenerDelegate?
    
    public init(parameters: EbtBalanceParameters, delegate: EbtBalanceListenerDelegate?) {
        var webResource: String
        var baseUrl: String
        let environment = parameters.environment ?? Environment.PRODUCTION
        switch environment {
        case Environment.SANDBOX:
            baseUrl = ebtBalanceSandboxURL
        case Environment.PRODUCTION:
            baseUrl = ebtBalanceProductionURL
        default:
            baseUrl = ebtBalanceProductionURL
        }
        webResource = baseUrl + "/?organizationId=" + parameters.organizationId + "&externalId=" + parameters.externalId + "&isWebView=true"
        self.organizationId = parameters.organizationId
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
}

public struct EbtBalanceViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewType = WKWebView
    var orgId: String
    var externalId: String
    var viewController: EbtBalanceViewController
    
    public init(parameters: EbtBalanceParameters, delegate: EbtBalanceListenerDelegate?) {
        self.orgId = parameters.organizationId
        self.externalId = parameters.externalId
        self.viewController = EbtBalanceViewController(parameters: parameters, delegate: delegate)
    }
    
    public func makeUIViewController(context _: Context) -> UIViewController {
        return viewController
    }

    // Added to conform to protocol
    public func updateUIViewController(_: UIViewController, context _: Context) {}
}
