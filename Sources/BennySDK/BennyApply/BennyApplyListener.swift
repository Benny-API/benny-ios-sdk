//
//  BennyApplyListener.swift
//
//
//  Created by Ariel Bong on 11/8/23.
//

import Foundation
import WebKit

public protocol BennyApplyListenerDelegate: AnyObject {
    func onExit()
    func onDataExchange(applicantDataId: String)
}

public class BennyApplyListener: NSObject, WKScriptMessageHandler {
    weak var webView: WKWebView?
    var delegate: BennyApplyListenerDelegate?
    public init(webView: WKWebView, delegate: BennyApplyListenerDelegate?) {
        self.webView = webView
        self.delegate = delegate
        super.init()
        let userContentController = self.webView?.configuration.userContentController
        userContentController?.removeAllScriptMessageHandlers()
        self.webView?.configuration.userContentController.add(self, name: "onExit")
        self.webView?.configuration.userContentController.add(self, name: "onDataExchange")
    }
    
    func onExit() {
        delegate?.onExit()
    }
    
    func onDataExchange(_ applicantDataId: String) {
        delegate?.onDataExchange(applicantDataId: applicantDataId)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "onExit":
            self.onExit()
        case "onDataExchange":
            if let applicantDataId = message.body as? String {
                self.onDataExchange(applicantDataId)
            } else {
                fatalError("Applicant Data ID is not a valid string")
            }
        default:
            return
        }
    }
}
