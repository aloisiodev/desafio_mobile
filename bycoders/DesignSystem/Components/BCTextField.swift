//
//  BCTextField.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import SwiftUI

struct BCTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(autocapitalization)
                    .autocorrectionDisabled()
            }
        }
        .padding(.horizontal, BCSpacing.lg)
        .frame(height: BCSpacing.Component.fieldHeight)
        .background(Color.BC.surface)
        .foregroundStyle(Color.BC.textPrimary)
    }
}
