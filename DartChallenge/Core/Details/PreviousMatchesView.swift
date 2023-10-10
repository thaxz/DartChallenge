//
//  PreviousMatchesView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct PreviousMatchesView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                HStack(spacing: 20){
                    Image("board")
                        .resizable()
                        .frame(width: 120, height: 120)
                    Text("PREVIOUS MATCHES")
                        .font(.custom("Futura-Bold", size: 32))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                // add list with for each macth
                MacthesRow()
                Spacer()
                PrimaryDestination(title: "main menu", destination: MenuView())
            }
            .padding(.horizontal, 20)
        }
    }
}

struct PreviousMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousMatchesView()
    }
}
