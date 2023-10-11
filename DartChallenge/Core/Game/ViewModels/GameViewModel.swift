//
//  GameViewModel.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    
    @StateObject var coordinator = Coordinator()
    
    @Published var throwNumber: Int = 0
    
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    
    func throwDart(){
        print(throwNumber)
        if throwNumber < 5 {
            coordinator.placeDart()
        } else if throwNumber >= 5 {
            coordinator.placeDart()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                self.gameOver()
            }
        }
    }
    
    func gameOver(){
        self.isGameOver = true
    }
    
    
}
