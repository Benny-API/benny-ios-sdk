//
//  TransferBaseView.swift
//  
//
//  Created by Ariel Bong on 4/26/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(red: 238/255, green: 238/255, blue: 238/255))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SF Pro", size: 16))
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .lineSpacing(12)
            .tracking(-0.43)
    }
}

extension View {
    func customTextStyle() -> some View {
        self.modifier(CustomTextStyle())
    }
}

public struct TransferBaseView: View {
    @State private var header: String
    @State private var subHeader: String
    @State private var inputText: String = ""
    @State private var primaryButtonText: String
    @State private var getIsPrimaryButtonDisabled: (String) -> Bool
    @State private var secondaryButtonText: String?
    @State private var primaryButtonAction: () -> Void
    @State private var isPinEntry: Bool
    @State private var secondaryButtonAction: (() -> Void)?

    public var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                ExitButton(action: {print("button tapped")})
            }

            Text(header)
                .font(.system(size: 22, weight: .semibold, design: .default))
                .fontWeight(.semibold)

            Text(subHeader)
                .font(.system(size: 16, weight: .regular, design: .default))
                .foregroundColor(Color(red: 108 / 255, green: 108 / 255, blue: 113 / 255))
                .frame(height: 28)

            VStack(spacing: 50) {
                if isPinEntry {
                    SecureField("", text: $inputText)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .textFieldStyle(CustomTextFieldStyle())
                        .frame(width: 180)
                        .cornerRadius(8.0)
                        .onChange(of: inputText) {
                            newValue in if newValue.count > 4 {
                                inputText = String(newValue.prefix(4))
                            }
                        }
                } else {
                    TextField("1234 1234 1234 1234", text: $inputText)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .textFieldStyle(CustomTextFieldStyle())
                        .frame(width: 240)
                        .cornerRadius(8.0)
                        .onChange(of: inputText) {
                            newValue in formatCardInput(newValue)
                        }
                }

                HStack {
                    if let secondaryButtonText = secondaryButtonText, !secondaryButtonText.isEmpty {
                        Button(secondaryButtonText, action: {
                            secondaryButtonAction?()
                        })
                            .padding()
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8.0)
                            .customTextStyle()
                    }

                    Button(primaryButtonText, action: {
                        primaryButtonAction()
                    })
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(getIsPrimaryButtonDisabled(inputText) ? Color(red: 0, green: 0, blue: 0, opacity: 0.2) : Color.black)
                        .cornerRadius(8.0)
                        .disabled(getIsPrimaryButtonDisabled(inputText))
                        .customTextStyle()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
    }

    public init(
        header: String,
        subHeader: String,
        primaryButtonText: String,
        getIsPrimaryButtonDisabled: @escaping (String) -> Bool,
        primaryButtonAction: @escaping () -> Void,
        secondaryButtonText: String?,
        secondaryButtonAction: (() -> Void)?,
        isPinEntry: Bool?
    ) {
        self.header = header
        self.subHeader = subHeader
        self.primaryButtonText = primaryButtonText
        self.secondaryButtonText = secondaryButtonText
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
        self.getIsPrimaryButtonDisabled = getIsPrimaryButtonDisabled
        self.isPinEntry = isPinEntry ?? false
    }

    private func formatCardInput(_ newValue: String) {
        // Remove any non-digit characters
        let filtered = newValue.filter { $0.isNumber }
        if filtered.count <= 16 {
            // Add spaces every four digits if 16 or fewer digits
            inputText = filtered.replacingOccurrences(of: "(\\d{4})(?!$)", with: "$1 ", options: .regularExpression)
        } else {
            // Remove all spaces once there are more than 16 digits and keep all digits
            inputText = filtered
        }
    }

    private func formatPinInput(_ newValue: String) {
        inputText = newValue.filter { $0.isNumber }
    }
}

#Preview {
    TransferBaseView(
        header: "Enter card number",
        subHeader: "Enter your EBT card number",
        primaryButtonText: "Next",
        getIsPrimaryButtonDisabled: { input in return input.filter { $0 != " " }.count < 16 },
        primaryButtonAction: { return },
        secondaryButtonText: "",
        secondaryButtonAction: {},
        isPinEntry: false
    )
}
