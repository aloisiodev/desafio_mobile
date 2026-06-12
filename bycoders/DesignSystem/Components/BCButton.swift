//
//  BCButton.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import SwiftUI

struct BCPrimaryButton: View {
    let label: String
    var isLoading: Bool = false
    var accessibilityId: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView().tint(Color.BC.textPrimary)
                } else {
                    Text(label)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
            }
            .font(Font.BC.button)
            .foregroundStyle(Color.BC.textPrimary)
            .padding(.horizontal, 20)
            .frame(height: BCSpacing.Component.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(Color.BC.primary)
        }
        .disabled(isLoading)
        .accessibilityIdentifier(accessibilityId ?? label)
    }
}

struct BCLinkButton: View {
    let leadingText: String
    let trailingText: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(leadingText).foregroundStyle(Color.BC.textSecondary)
                Text(trailingText).fontWeight(.semibold).foregroundStyle(Color.BC.link)
                Spacer()
                Image(systemName: "arrow.right").foregroundStyle(Color.BC.link)
            }
            .font(Font.BC.body)
        }
    }
}

struct BCTextButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Font.BC.body)
                .foregroundStyle(Color.BC.link)
        }
    }
}
