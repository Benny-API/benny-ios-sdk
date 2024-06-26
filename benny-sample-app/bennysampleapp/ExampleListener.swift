//
//  ExampleListener.swift
//  bennysampleapp
//
//  Created by Ariel Bong on 11/17/23.
//

import Foundation
import SwiftUI
import BennySDK

class ExampleEbtBalanceListener: EbtBalanceListenerDelegate {
    var isPresentingView: Binding<Bool>

    init(isPresentingView: Binding<Bool>) {
        self.isPresentingView = isPresentingView
    }

    func onExit() {
        print("exiting flow")
        isPresentingView.wrappedValue.toggle()
    }

    /**
     *   Deprecated in favor of onLinkResult
     */

    func onLinkSuccess(linkToken: String) {
        print("link success")
        print(linkToken)
    }

    func onLinkResult(result: LinkResultMessage) {
        print("link result")
        print((result.result as LinkResultSuccess).linkToken)
    }
}
