//
//  MenuView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Image("menuBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20){
                Image("logo")
                    .padding(.top, 70)
                Spacer()
                PrimaryButton(title: "play") {
                    // go to gameview
                }
                SecondaryButton(title: "previous macthes") {
                    // go to previous matches view
                }
                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
