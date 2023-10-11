//
//  GameViewModel.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var throwNumber: Int = 0
    
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    @Published var dartResults: [Bool] = []
    
    var startTime: Date? = nil
    var endTime: Date? = nil
    
    func changeBoard(){
        ARManager.shared.actionsStream.send(.placeBoard)
    }
    
    func gameOver(){
        isGameOver = true
        endTime = Date()
    }
    
    
}
