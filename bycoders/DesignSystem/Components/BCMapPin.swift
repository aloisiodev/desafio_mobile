//
//  BCMapPin.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import SwiftUI

struct BCMapPin: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.BC.primary.opacity(0.25))
                .frame(width: BCSpacing.Component.iconTap, height: BCSpacing.Component.iconTap)

            Circle()
                .fill(Color.BC.primary)
                .frame(width: 18, height: 18)
        }
    }
}
