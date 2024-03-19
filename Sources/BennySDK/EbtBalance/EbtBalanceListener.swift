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
    func onCopyToClipboard(text: String)
    func onOpenUrl(url: String)
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
        self.webView?.configuration.userContentController.add(self, name: "onExit")
        self.webView?.configuration.userContentController.add(self, name: "onCopyToClipboard")
        self.webView?.configuration.userContentController.add(self, name: "onLinkSuccess")
        self.webView?.configuration.userContentController.add(self, name: "onOpenUrl")
    }
    
    
    func onExit() {
        delegate?.onExit()
    }
    
    func onLinkSuccess(linkToken: String) {
        delegate?.onLinkSuccess(linkToken: linkToken)
    }
    
    func onOpenUrl(url: String) {
        delegate?.onOpenUrl(url: url)
    }
    
    func onCopyToClipboard(text: String) {
        delegate?.onCopyToClipboard(text: text)
    }
    
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "onExit":
            self.onExit()
        case "onLinkSuccess":
            if let linkSuccessMessage = message.body as? LinkSuccessMessage {
                self.onLinkSuccess(linkToken: linkSuccessMessage.linkToken)
            } else {
                fatalError("Link token is not a valid string.")
            }
        case "onOpenUrl":
            if let url = message.body as? String {
                self.onOpenUrl(url: url)
            } else {
                fatalError("Url is not valid.")
            }
        case "onCopyToClipboard":
            if let clipboardMessage = message.body as? CopyToClipboardMessage {
                self.onCopyToClipboard(text: clipboardMessage.text)
            } else {
                fatalError("Text not available to copy.")
            }
        default:
            return
        }
    }
}
