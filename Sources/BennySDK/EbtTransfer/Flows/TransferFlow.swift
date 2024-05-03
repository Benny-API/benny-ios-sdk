//
//  TransferFlow.swift
//
//
//  Created by Ariel Bong on 4/30/24.
//

import SwiftUI

public struct TransferFlow: View {
    var params: EbtTransferParameters
    @State var pin: String = ""
    @State var errorMessage: String = ""
    var onExit: () -> Void
    var onResult: (_ error: String?) -> Void

    public var body: some View {
        TransferBaseView(
            inputText: $pin,
            errorMessage: $errorMessage,
            header: "Approve transfer",
            subHeader: "Enter your EBT card PIN",
            primaryButtonText: "Transfer",
            getIsPrimaryButtonDisabled: { input in return input.count < 4 },
            primaryButtonAction: { Task {
                await transfer(pin: pin)
            }},
            secondaryButtonText: nil,
            secondaryButtonAction: {},
            onExit: onExit,
            isPinEntry: true
        )
    }

    public init(
        parameters: EbtTransferParameters,
        onExit: @escaping () -> Void,
        onResult: @escaping (_ error: String?) -> Void) {
        self.params = parameters
        self.onExit = onExit
        self.onResult = onResult
    }

    private func transfer(pin: String) async {
        let result = await postTransferRequest(
            env: params.environment,
            organizationId: params.organizationId,
            request: TransferRequest(
                idempotencyKey: params.idempotencyKey,
                amount: params.amount,
                transferToken: params.transferToken,
                pin: pin
            )
        )

        if case .success(let response) = result {
            onResult(nil)
        } else if case .failure(let error) = result {
            switch error.code {
            case .invalidCardInfo:
                DispatchQueue.main.async {
                    errorMessage = error.message
                }
            default:
                onResult(error.code.rawValue)
            }
        }
    }
}
