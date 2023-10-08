//
//  PauseView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct PauseView: View {
    
    let play: () -> ()
    let mainMenu: () -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.thinMaterial)
                .ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.theme.primary, lineWidth: 5)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(.theme.secondary)
                    )
                VStack(spacing: 40){
                    Text("PAUSED")
                        .font(.custom("Futura-Bold", size: 48))
                        .foregroundColor(.white)
                    HStack{
                        Button {
                            play()
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.theme.primary)
                                .frame(width: 80, height: 80)
                                .overlay(
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 33)
                                )
                        }
                        Spacer()
                        Button {
                           mainMenu()
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.theme.primary)
                                .frame(width: 80, height: 80)
                                .overlay(
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 47, height: 44)
                                )
                        }
                    }
                }
                .padding(.horizontal, 55)
            }
            .frame(width: 320, height: 340)
        }
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView(play: {}, mainMenu: {})
    }
}
