//
//  CheckBalanceFlow.swift
//
//
//  Created by Ariel Bong on 4/30/24.
//

import SwiftUI

public struct CheckBalanceFlow: View {
    @State var params: EbtTransferCheckBalanceParameters
    @State var pin: String = ""
    public var body: some View {
        TransferBaseView(
            inputText: $pin,
            header: "Check balance",
            subHeader: "Enter your EBT card PIN",
            primaryButtonText: "Check balance",
            getIsPrimaryButtonDisabled: { input in return input.count < 4 },
            primaryButtonAction: { print("text") },
            secondaryButtonText: nil,
            secondaryButtonAction: {},
            isPinEntry: true
        )
    }

    public init(params: EbtTransferCheckBalanceParameters) {
        self.params = params
    }
}
