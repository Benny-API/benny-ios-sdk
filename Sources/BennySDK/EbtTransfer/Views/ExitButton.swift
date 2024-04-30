//
//  ExitButton.swift
//
//
//  Created by Ariel Bong on 4/26/24.
//

import SwiftUI

public struct ExitButton: View {
    // Action to perform when the button is tapped
    let action: () -> Void
    public var body: some View {
        VStack {
            Button(action: {

            }) {
                // Label of the button
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .semibold))
                     .foregroundColor(.black) // Text color
                     .frame(width: 36, height: 36)
                     .background(Circle()
                                     .fill(Color(red: 238/255, green: 238/255, blue: 238/255)))
                     .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
            .accessibilityLabel("Close")
        }
    }

    public init(action: @escaping () -> Void) {
        self.action = action
    }
}

struct ExitButton_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton(action: {
            print("Button tapped")
        })
    }
}
