//
//  SwiftUIView.swift
//  
//
//  Created by Ariel Bong on 4/25/24.
//

import SwiftUI

struct EnterCardView: View {
    @Binding private var cardNumber: String
    @State private var isValid: Bool = false
    @EnvironmentObject var router: Router
    @State private var errorMessage: String = ""
    var onExit: () -> Void

    var body: some View {
        TransferBaseView(
            inputText: $cardNumber,
            errorMessage: $errorMessage,
            header: "Enter card number",
            subHeader: "Enter your EBT card number",
            primaryButtonText: "Next",
            getIsPrimaryButtonDisabled: { input in return input.filter { $0 != " " }.count < 16},
            primaryButtonAction: { router.navigate(to: .confirmPin)},
            secondaryButtonText: "",
            secondaryButtonAction: {},
            onExit: onExit,
            isPinEntry: false
        )
    }

    init(cardNumber: Binding<String>, onExit: @escaping () -> Void) {
        self._cardNumber = cardNumber
        self.onExit = onExit
    }
}
