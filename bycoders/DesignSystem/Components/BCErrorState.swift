//
//  BCErrorState.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import SwiftUI

struct BCErrorState: View {
    let icon: String
    var iconColor: Color = Color.BC.textPrimary
    let title: String
    var description: String? = nil
    var actionLabel: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Color.BC.background.ignoresSafeArea()

            VStack(spacing: BCSpacing.lg) {
                Image(systemName: icon)
                    .font(.system(size: 48))
                    .foregroundStyle(iconColor)

                Text(title)
                    .font(Font.BC.button)
                    .foregroundStyle(Color.BC.textPrimary)

                if let description {
                    Text(description)
                        .font(Font.BC.body)
                        .foregroundStyle(Color.BC.textSecondary)
                }

                if let actionLabel, let action {
                    BCTextButton(label: actionLabel, action: action)
                }
            }
        }
    }
}
