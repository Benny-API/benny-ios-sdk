//
//  Mocks.swift
//  
//
//  Created by Ariel Bong on 11/15/23.
//

import Foundation
import WebKit

class MockWKWebView: WKWebView {
    var lastLoadedRequest: URLRequest?

    override func load(_ request: URLRequest) -> WKNavigation? {
        lastLoadedRequest = request
        return nil
    }
}
