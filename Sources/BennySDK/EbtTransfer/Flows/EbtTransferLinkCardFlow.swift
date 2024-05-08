//
//  EbtTransferLinkCardFlow.swift
//
//
//  Created by Ariel Bong on 4/29/24.
//

import SwiftUI

public struct EbtTransferLinkCardFlow: View {
    var parameters: EbtTransferLinkCardParameters
    var onExit: () -> Void
    var onLinkResult: (_ transferToken: String?, _ expiration: String?, _ errorDescription: String?) -> Void
    @ObservedObject var router = Router()
    @State var cardNumber: String = ""

    public var body: some View {
        NavigationStack(path: $router.navPath) {
            EnterCardView(cardNumber: $cardNumber, onExit: onExit)
                .navigationDestination(for: Router.Destination.self) {
                destination in switch destination {
                    case .enterCard:
                    EnterCardView(cardNumber: $cardNumber, onExit: onExit)
                    case .confirmPin:
                    ConfirmPinView(cardNumber: $cardNumber, parameters: parameters, onExit: onExit, onLinkResult: onLinkResult)
                }
            }
        }
        .environmentObject(router)
    }

    public init(
        parameters: EbtTransferLinkCardParameters,
        onExit: @escaping () -> Void,
        onLinkResult: @escaping (_ transferToken: String?, _ expiration: String?, _ errorDescription: String?) -> Void) {
        self.parameters = parameters
        self.onExit = onExit
        self.onLinkResult = onLinkResult
    }
}
