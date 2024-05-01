//
//  ConfirmPinView.swift
//  
//
//  Created by Ariel Bong on 4/29/24.
//

import SwiftUI
import UIKit

private var ProductionBaseURL = "https://api-production.bennyapi.com"
private var SandboxBaseURL = "https://api-sandbox.bennyapi.com"

struct ConfirmPinView: View {
    @EnvironmentObject var router: Router
    @State var params: EbtTransferLinkCardParameters
    @Binding var cardNumber: String
    @State var pin: String = ""

    var body: some View {
        TransferBaseView(
            inputText: $pin,
            header: "Confirm PIN",
            subHeader: "Enter your EBT card PIN",
            primaryButtonText: "Confirm",
            getIsPrimaryButtonDisabled: { input in return input.count < 4 },
            primaryButtonAction: { print("text") },
            secondaryButtonText: "Edit Card",
            secondaryButtonAction: { router.navigateBack() },
            isPinEntry: true
        )
    }

    init(cardNumber: Binding<String>, parameters: EbtTransferLinkCardParameters) {
        self._cardNumber = cardNumber
        self.params = parameters
    }

    private func exchangeTemporaryLink(pin: String) async throws -> ExchangeTemporaryLinkResponse {
        let baseUrl: String
        let environment = params.environment ?? Environment.PRODUCTION
        switch environment {
        case Environment.SANDBOX:
            baseUrl = ProductionBaseURL
        case Environment.PRODUCTION:
            baseUrl = SandboxBaseURL
        default:
            baseUrl = ProductionBaseURL
        }
        let url = URL(string: baseUrl + "v1/ebt/transfer/link/exchange")!
        let (data, _ ) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ExchangeTemporaryLinkResponse.self, from: data)
        return response
    }
}

#Preview {
    ConfirmPinView(
        cardNumber: .constant("1235 1234 1234 1231 1233"),
        parameters: EbtTransferLinkCardParameters(
            organizationId: "",
            environment: Environment.SANDBOX,
            temporaryLink: ""
        ))
}
