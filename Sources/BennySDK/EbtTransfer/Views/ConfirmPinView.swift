//
//  ConfirmPinView.swift
//  
//
//  Created by Ariel Bong on 4/29/24.
//

import SwiftUI
import UIKit

struct ConfirmPinView: View {
    @EnvironmentObject var router: Router
    @Binding var cardNumber: String
    @State var pin: String = ""
    @State var errorMessage: String = ""
    var parameters: EbtTransferLinkCardParameters
    var onExit: () -> Void
    var onLinkResult: (_ transferToken: String?, _ expiration: String?, _ errorDescription: String?) -> Void

    var body: some View {
        TransferBaseView(
            inputText: $pin,
            errorMessage: $errorMessage,
            header: "Confirm PIN",
            subHeader: "Enter your EBT card PIN",
            primaryButtonText: "Confirm",
            getIsPrimaryButtonDisabled: { input in return input.count < 4 },
            primaryButtonAction: { Task {
                await exchangeTemporaryLink(pin: pin)
            }},
            secondaryButtonText: "Edit Card",
            secondaryButtonAction: { router.navigateBack() },
            onExit: onExit,
            isPinEntry: true
        )
    }

    init( cardNumber: Binding<String>,
     parameters: EbtTransferLinkCardParameters,
     onExit: @escaping () -> Void,
     onLinkResult: @escaping (_ transferToken: String?, _ expiration: String?, _ errorDescription: String?) -> Void
    ) {
        self._cardNumber = cardNumber
        self.parameters = parameters
        self.onExit = onExit
        self.onLinkResult = onLinkResult
    }

    private func exchangeTemporaryLink(pin: String) async {
        let result = await postExchangeTemporaryLinkRequest(
            env: parameters.environment ?? Environment.PRODUCTION,
            organizationId: parameters.organizationId,
            request: ExchangeTemporaryLinkRequest(
                temporaryLink: parameters.temporaryLink,
                accountNumber: cardNumber,
                pin: pin
            ))

        if case .success(let response) = result {
            onLinkResult(response.transferToken, response.expiration, nil)
        } else if case .failure(let error) = result {
            switch error.code {
            case .invalidCardInfo:
                errorMessage = error.message
            default:
                onLinkResult(nil, nil, error.code.rawValue)
            }
        }
    }
}

#Preview {
    ConfirmPinView(
        cardNumber: .constant("1235 1234 1234 1231 1233"),
        parameters: EbtTransferLinkCardParameters(organizationId: "org", environment: Environment.PRODUCTION, temporaryLink: "temp_link"),
        onExit: {},
        onLinkResult: {_, _, _ in ()}
    )
}
