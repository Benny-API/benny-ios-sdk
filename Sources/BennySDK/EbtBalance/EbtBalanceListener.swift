//
//  EbtBalanceListener.swift
//
//
//  Created by Ariel Bong on 3/18/24.
//

import Foundation
import WebKit

public protocol EbtBalanceListenerDelegate : AnyObject {
    func onExit()
    func onLinkSuccess(linkToken: String)
}

public class EbtBalanceListener: NSObject, WKScriptMessageHandler {
    weak var webView: WKWebView?
    var delegate: EbtBalanceListenerDelegate?
    public init(webView: WKWebView, delegate: EbtBalanceListenerDelegate?) {
        self.webView = webView
        self.delegate = delegate
        super.init()
        let userContentController = self.webView?.configuration.userContentController
        userContentController?.removeAllScriptMessageHandlers()
        self.webView?.configuration.userContentController.add(self, name: "Exit")
        self.webView?.configuration.userContentController.add(self, name: "CopyToClipboard")
        self.webView?.configuration.userContentController.add(self, name: "LinkSuccess")
        self.webView?.configuration.userContentController.add(self, name: "OpenUrlExternally")
    }
    
    
    func onExit() {
        delegate?.onExit()
    }
    
    func onLinkSuccess(linkToken: String) {
        delegate?.onLinkSuccess(linkToken: linkToken)
    }
    
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "Exit":
            self.onExit()
        case "LinkSuccess":
            if let linkToken = message.body as? String {
                self.onLinkSuccess(linkToken: linkToken)
            } else {
                fatalError("Link token is not a valid string.")
            }
        default:
            return
        }
    }
}
