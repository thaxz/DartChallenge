//
//  Pages.swift
//  DartChallenge
//
//  Created by thaxz on 09/10/23.
//

import Foundation

// Creating an enum with all pages

enum Page: String, Identifiable {
    
    case menu, game, pause, endGame, matchDetails, previousMatches
    // Needs an id to be identifiable
    var id: String {
        self.rawValue
    }
}
