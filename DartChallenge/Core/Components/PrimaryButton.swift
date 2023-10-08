//
//  PrimaryButton.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button {
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.theme.primary)
                Text(title.uppercased())
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "play", action: {})
    }
}
