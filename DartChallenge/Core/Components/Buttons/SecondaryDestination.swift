//
//  SecondaryButton.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct SecondaryDestination: View {
    let title: String
    let destination: any View
    var body: some View {
        NavigationLink {
            AnyView(destination)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primary, lineWidth: 3)
                    .background(
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.theme.secondary)
                    )
                Text(title.uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryDestination(title: "previous matches", destination: EmptyView())
    }
}
