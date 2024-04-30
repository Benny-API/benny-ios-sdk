//
//  LinkCard.swift
//
//
//  Created by Ariel Bong on 4/29/24.
//

import SwiftUI

public struct LinkCardFlow: View {

    @ObservedObject var router = Router()

    public var body: some View {
        NavigationStack(path: $router.navPath) {
            EnterCardView()
                .navigationDestination(for: Router.Destination.self) {
                destination in switch destination {
                    case .enterCard:
                        EnterCardView()
                    case .confirmPin:
                        ConfirmPinView()
                }
            }
        }
        .environmentObject(router)
    }
}
