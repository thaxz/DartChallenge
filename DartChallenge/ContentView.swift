//
//  ContentView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import SwiftUI
import ARKit

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            ARViewContainer(coordinator: coordinator)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Button {
                        ARManager.shared.actionsStream.send(.placeBoard)
                    } label: {
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(16)
                    }
                    Button {
                        coordinator.placeDart()
                    } label: {
                        Image(systemName: "square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(16)
                    }
                }
            }
            .onReceive(timer) { _ in
                ARManager.shared.actionsStream.send(.removeDart)
//                ARManager.shared.actionsStream.send(.checkCollision)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
