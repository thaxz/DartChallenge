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
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    
    @State var isPaused: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ARViewContainer(coordinator: coordinator)
                .ignoresSafeArea()
            VStack {
                headerSection
                Spacer()
                trowButton
            }
            .padding(40)
            .onReceive(timer) { _ in
                ARManager.shared.actionsStream.send(.removeDart)
//                ARManager.shared.actionsStream.send(.checkCollision)
            }
            if isPaused {
                PauseView()
            }
        }
        .onAppear{
            viewModel.startTime = Date()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isGameOver, destination: {
            EndMatchView(match: viewModel.match ?? mockMatches[0])
        })
    }
}

// MARK: Components

extension GameView {
    
    var headerSection: some View{
        HStack{
            Spacer()
            Text("Darts thrown: \(viewModel.throwNumber)")
                .font(.custom("Futura-Bold", size: 22))
                .foregroundColor(.white)
            Spacer()
            Button {
                ARManager.shared.actionsStream.send(.pause)
                routerManager.push(to: .pause)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    viewModel.changeBoard()
                }
            } else if viewModel.throwNumber >= 5 {
                coordinator.placeDart()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
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
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(NavigationRouter())
    }
}
