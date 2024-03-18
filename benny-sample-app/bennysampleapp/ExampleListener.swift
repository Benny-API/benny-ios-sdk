//
//  ExampleListener.swift
//  bennysampleapp
//
//  Created by Ariel Bong on 11/17/23.
//

import Foundation
import BennySDK
import SwiftUI

class ExampleEbtBalanceListener: EbtBalanceListenerDelegate {
    var isPresentingView: Binding<Bool>
    
    init(isPresentingView: Binding<Bool>) {
        self.isPresentingView = isPresentingView
    }
    
    func onExit() {
        print("exiting flow")
        isPresentingView.wrappedValue.toggle()
    }
    
    func onDataExchange(applicantDataId: String) {
        print("data exchange commenced")
        print(applicantDataId)
    }
}
