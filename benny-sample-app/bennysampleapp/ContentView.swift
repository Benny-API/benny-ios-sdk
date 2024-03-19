//
//  ContentView.swift
//  bennysampleapp
//
//  Created by Ariel Bong on 11/17/23.
//

import SwiftUI
import BennySDK

struct ContentView: View {
    @State private var isPresentingViewController = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello!")
                Button("Present Ebt Balance View Controller") {
                    isPresentingViewController.toggle()
                }.sheet(isPresented: $isPresentingViewController, content: {
                    controller
                })
            }
        }
    }
    
    var controller: EbtBalanceViewControllerRepresentable {
        let ebtBalanceParams = EbtBalancePararmeters(organizationId: "org_ne8x62s1yk5vgtup4g1240lh", temporaryLink: "example", environment: Environment.SANDBOX)
        let listener = ExampleEbtBalanceListener(isPresentingView: $isPresentingViewController)
        return EbtBalanceViewControllerRepresentable(parameters: ebtBalanceParams, delegate: listener)
    }
}r

#Preview {
    ContentView()
}
