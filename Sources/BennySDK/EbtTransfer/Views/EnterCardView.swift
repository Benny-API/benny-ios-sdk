//
//  SwiftUIView.swift
//  
//
//  Created by Ariel Bong on 4/25/24.
//

import SwiftUI

public struct EnterCardView: View {
    @State private var cardNumber: String = ""
    @State private var isValid: Bool = false

    @EnvironmentObject var router: Router

    public var body: some View {
        TransferBaseView(
            header: "Enter card number",
            subHeader: "Enter your EBT card number",
            primaryButtonText: "Next",
            getIsPrimaryButtonDisabled: { input in return input.filter { $0 != " " }.count < 16},
            primaryButtonAction: { router.navigate(to: .confirmPin)},
            secondaryButtonText: "",
            secondaryButtonAction: {},
            isPinEntry: false
        )
    }

    public init() {
        return
    }
}

#Preview {
    EnterCardView()
}
