//
//  BCColors.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import SwiftUI

extension Color {
    enum BC {
        static let background    = Color(hex: "#161616")
        static let surface       = Color(hex: "#262626")
        static let divider       = Color(hex: "#393939")
        static let primary       = Color(hex: "#0F62FE")
        static let link          = Color(hex: "#78A9FF")
        static let textPrimary   = Color.white
        static let textSecondary = Color(hex: "#C6C6C6")
        static let overlay       = Color.black.opacity(0.65)
    }
}
