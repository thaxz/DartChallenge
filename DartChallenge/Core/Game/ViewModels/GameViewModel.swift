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
    
    func throwDart(){
        
    }
    
    func gameOver(){
        self.isGameOver = true
        
        // criar end time da match
    }
    
    
}
