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
    
    func onOpenUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
          return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func onCopyToClipboard(text: String) {
        UIPasteboard.generalPasteboard().string = text
    }
    
    func getJsonData<T: Decodable>(message: WKScriptMessage, type: T.Type) throws -> T {
        guard let jsonString = message.body as? String else {
             throw NSError(domain: "InvalidMessageError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Message body is not a valid string."])
         }

         guard let jsonData = jsonString.data(using: .utf8) else {
             throw NSError(domain: "InvalidJSONError", code: 0, userInfo: [NSLocalizedDescriptionKey: "The string could not be converted to JSON data."])
         }
        return try JSONDecoder().decode(T.self, from: jsonData)
    }
    
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "onExit":
            self.onExit()
        case "onLinkSuccess":
            do {
                let linkSuccessMessage = try getJsonData(message: message, type: LinkSuccessMessage.self)
                self.onLinkSuccess(linkToken: linkSuccessMessage.linkToken)
            } catch {
                fatalError("Error getting link token.")
            }
        case "onOpenUrl":
            do {
                let openUrlMessage = try getJsonData(message: message, type: OpenUrlMessage.self)
                self.onOpenUrl(urlString: openUrlMessage.url)
            } catch {
                fatalError("Error getting url.")
            }
        case "onCopyToClipboard":
            do {
                let copyToClipboardMessage = try getJsonData(message: message, type: CopyToClipboardMessage.self)
                self.onCopyToClipboard(text: copyToClipboardMessage.text)
            } catch {
                fatalError("Error copying to clipboard.")
            }
        default:
            return
        }
    }
}
