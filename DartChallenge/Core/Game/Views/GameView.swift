//
//  ContentView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import SwiftUI
import ARKit

struct GameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var coordinator = Coordinator()
    @StateObject private var viewModel = GameViewModel()
    
    @State var isPaused: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ARViewContainer(coordinator: coordinator)
                .ignoresSafeArea()
            VStack {
                pauseButton
                Spacer()
                trowButton
                placeBoardButton
            }
            .padding(40)
            .onReceive(timer) { _ in
                ARManager.shared.actionsStream.send(.removeDart)
                //                ARManager.shared.actionsStream.send(.checkCollision)
            }
            if isPaused {
                PauseView {
                    isPaused = false
                } mainMenu: {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isGameOver, destination: {
           EndMatchView()
        })
    }
}

// MARK: Components

extension GameView {
    
    var pauseButton: some View{
        HStack{
            Spacer()
            Button {
                isPaused = true
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
            viewModel.throwNumber += 1
            if viewModel.throwNumber < 5 {
                coordinator.placeDart()
            } else if viewModel.throwNumber >= 5 {
                coordinator.placeDart()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    viewModel.gameOver()
                }
            }
            
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
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
