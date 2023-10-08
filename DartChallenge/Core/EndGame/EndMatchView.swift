//
//  EndMatchView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct EndMatchView: View {
    var body: some View {
        ZStack {
            Image("endMatchBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 32){
                Text("END OF THE MATCH")
                    .font(.custom("Futura-Bold", size: 50))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 70)
                Image("board")
                    .resizable()
                    .frame(width: 120, height: 120)
                pointsSection
                timeSection
                Spacer()
                PrimaryButton(title: "see details") {
                    // go to details view
                }
                SecondaryButton(title: "main menu") {
                    // go to the main menu
                }
                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: Components

extension EndMatchView {
    
    var pointsSection: some View {
        VStack{
            Text("YOU ACHIEVED")
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(.white)
            Text("X POINTS")
                .font(.custom("Futura-Medium", size: 22))
                .underline()
                .foregroundColor(.white)
        }
    }
    
    var timeSection: some View {
        HStack{
            Image(systemName: "clock")
                .resizable()
                .foregroundColor(Color.theme.primary)
                .frame(width: 26, height: 26)
            Text("IN X MINUTES".uppercased())
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(Color.theme.primary)
        }
    }
    
}

struct EndMatchView_Previews: PreviewProvider {
    static var previews: some View {
        EndMatchView()
    }
}
