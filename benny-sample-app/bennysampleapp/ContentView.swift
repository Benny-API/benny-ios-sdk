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
                Button("Present Benny Apply View Controller") {
                    isPresentingViewController.toggle()
                }.sheet(isPresented: $isPresentingViewController, content: {
                    controller
                })
            }
        }
    }
    
    var controller: BennyApplyViewControllerRepresentable {
        let bennyApplyParams = BennyApplyParameters(organizationId: "org_ne8x62s1yk5vgtup4g1240lh", externalId: "example", environment: Environment.SANDBOX)
        let listener = ExampleBennyApplyListener(isPresentingView: $isPresentingViewController)
        return BennyApplyViewControllerRepresentable(parameters: bennyApplyParams, delegate: listener)
    }
}

#Preview {
    ContentView()
}
