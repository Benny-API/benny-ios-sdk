//
//  TransferFlow.swift
//
//
//  Created by Ariel Bong on 4/30/24.
//

import SwiftUI

public struct TransferFlow: View {
    @State private var params: EbtTransferParameters
    @State private var pin: String = ""
    public var body: some View {
        TransferBaseView(
            inputText: $pin,
            header: "Approve transfer",
            subHeader: "Enter your EBT card PIN",
            primaryButtonText: "Transfer",
            getIsPrimaryButtonDisabled: { input in return input.count < 4 },
            primaryButtonAction: { print("text") },
            secondaryButtonText: nil,
            secondaryButtonAction: {},
            isPinEntry: true
        )
    }

    public init(params: EbtTransferParameters) {
        self.params = params
    }
}
