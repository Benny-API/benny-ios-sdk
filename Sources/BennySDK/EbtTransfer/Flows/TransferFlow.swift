//
//  TransferFlow.swift
//
//
//  Created by Ariel Bong on 4/30/24.
//

import SwiftUI

public struct TransferFlow: View {
    public var body: some View {
        TransferBaseView(
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
}

#Preview {
    TransferFlow()
}
