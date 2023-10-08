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
                    PrimaryButton(title: "throw") {
                        coordinator.placeDart()
                    }
                    .padding(.horizontal, 30)
                    PrimaryButton(title: "place board") {
                        ARManager.shared.actionsStream.send(.placeBoard)
                    }
                    .padding(.horizontal, 30)
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
