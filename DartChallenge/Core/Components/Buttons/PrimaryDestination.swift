//
//  PrimaryDestination.swift
//  DartChallenge
//
//  Created by thaxz on 09/10/23.
//

import SwiftUI

struct PrimaryDestination: View {
    let title: String
    let destination: any View
    var body: some View {
        NavigationLink {
            AnyView(destination)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.theme.primary)
                Text(title.uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

struct PrimaryDestination_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryDestination(title: "play", destination: MenuView())
    }
}
