//  BaseView.swift
import SwiftUI
import UIKit
import WebKit

class BaseWebViewVM: ObservableObject {
    @Published var webResource: String?
    var webView: WKWebView

    init(webResource: String? = nil) {
        self.webResource = webResource
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    }

    func loadWebPage() {
        if let webResource = webResource {
            guard let url = URL(string: webResource) else {
                print("Not a valid url")
                return
            }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
