//
//  ContentView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ARViewContainer()
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
                       // ARManager.shared.actionsStream.send(.placeDart)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
