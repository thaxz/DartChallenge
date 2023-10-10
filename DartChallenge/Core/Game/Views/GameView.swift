//
//  ContentView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import SwiftUI
import ARKit

struct GameView: View {
    
    @StateObject private var coordinator = Coordinator()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ARViewContainer(coordinator: coordinator)
                .ignoresSafeArea()
            VStack {
                pauseSection
                Spacer()
                trowButton
                placeBoardButton
            }
            .padding(.horizontal, 20)
            .onReceive(timer) { _ in
                ARManager.shared.actionsStream.send(.removeDart)
                //                ARManager.shared.actionsStream.send(.checkCollision)
            }
        }
    }
}

// MARK: Components

extension GameView {
    
    var pauseSection: some View{
        HStack{
            Spacer()
            Button {
                // pause
            } label: {
                Image(systemName: "pause.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        }
    }
    
    var trowButton: some View {
        Button {
            coordinator.placeDart()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.theme.primary)
                Text("trow".uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal, 30)
    }
    
    var placeBoardButton: some View {
        Button {
            ARManager.shared.actionsStream.send(.placeBoard)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.theme.primary)
                Text("Place board".uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal, 30)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
