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
        let ebtBalanceParams = EbtBalanceParameters(organizationId: "org_wup29bz683g8habsxvazvyz1", environment: Environment.SANDBOX, temporaryLink: "example")
        let listener = ExampleEbtBalanceListener(isPresentingView: $isPresentingViewController)
        return EbtBalanceViewControllerRepresentable(parameters: ebtBalanceParams, delegate: listener)
    }
}

#Preview {
    ContentView()
}
