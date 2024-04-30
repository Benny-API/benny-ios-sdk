//
//  ConfirmPinView.swift
//  
//
//  Created by Ariel Bong on 4/29/24.
//

import SwiftUI

public struct ConfirmPinView: View {
    @EnvironmentObject var router: Router

    public var body: some View {
        TransferBaseView(
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

    public init() {
        return
    }
}

#Preview {
    ConfirmPinView()
}
