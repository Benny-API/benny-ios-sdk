//
//  CheckBalanceFlow.swift
//
//
//  Created by Ariel Bong on 4/30/24.
//

import SwiftUI

public struct CheckBalanceFlow: View {
    @EnvironmentObject var router: Router

    public var body: some View {
        TransferBaseView(
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
}

#Preview {
    CheckBalanceFlow()
}
