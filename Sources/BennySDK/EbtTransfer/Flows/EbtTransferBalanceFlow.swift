//
//  EbtTransferBalanceFlow.swift
//
//
//  Created by Ariel Bong on 4/30/24.
//

import SwiftUI

public struct EbtTransferBalanceFlow: View {
    @State var pin: String = ""
    @State private var errorMessage: String = ""
    var params: EbtTransferBalanceParameters
    var onExit: () -> Void
    var onResult: (_ balance: Int?, _ error: String?) -> Void

    public var body: some View {
        TransferBaseView(
            inputText: $pin,
            errorMessage: $errorMessage,
            header: "Check balance",
            subHeader: "Enter your EBT card PIN",
            primaryButtonText: "Check balance",
            getIsPrimaryButtonDisabled: { input in return input.count < 4 },
            primaryButtonAction: { Task { await checkBalance(pin: pin) }},
            secondaryButtonText: nil,
            secondaryButtonAction: {},
            onExit: onExit,
            isPinEntry: true
        )
    }

    public init(paramaters: EbtTransferBalanceParameters, onExit: @escaping () -> Void, onResult: @escaping (_ balance: Int?, _ error: String?) -> Void) {
        self.params = paramaters
        self.onExit = onExit
        self.onResult = onResult
    }

    private func checkBalance(pin: String) async {
        let result = await postCheckBalanceRequest(
            env: params.environment,
            organizationId: params.organizationId,
            request: CheckBalanceRequest(
                transferToken: params.transferToken,
                pin: pin
            )
        )

        if case .success(let response) = result {
            if let userBalance = response.balance {
                onResult(userBalance, nil)
            }

            if let numAttemptsLeft = response.numAttemptsLeft {
                if numAttemptsLeft == 0 {
                    onResult(nil, TransferApiErrorCode.maxAttemptsExceeded.rawValue)
                } else {
                    errorMessage = "Incorrect PIN. You have \(numAttemptsLeft) attempts remaining."
                }
            }
        } else if case .failure(let error) = result {
            switch error.code {
            case .invalidCardInfo:
                errorMessage = error.message
            default:
                onResult(nil, errorMessage)
            }
        }
    }
}
