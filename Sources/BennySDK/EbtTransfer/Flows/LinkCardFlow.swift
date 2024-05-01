//
//  LinkCard.swift
//
//
//  Created by Ariel Bong on 4/29/24.
//

import SwiftUI

public struct LinkCardFlow: View {

    @ObservedObject var router = Router()
    @State var params: EbtTransferLinkCardParameters
    @State var cardNumber: String = ""

    public var body: some View {
        NavigationStack(path: $router.navPath) {
            EnterCardView(cardNumber: $cardNumber)
                .navigationDestination(for: Router.Destination.self) {
                destination in switch destination {
                    case .enterCard:
                    EnterCardView(cardNumber: $cardNumber)
                    case .confirmPin:
                    ConfirmPinView( cardNumber: $cardNumber, parameters: params)
                }
            }
        }
        .environmentObject(router)
    }

    public init(parameters: EbtTransferLinkCardParameters) {
        self.params = parameters
    }
}
