//
//  Match.swift
//  DartChallenge
//
//  Created by thaxz on 13/10/23.
//

import Foundation

struct Match: Identifiable, Hashable {
    
    let id = UUID()
    let startDate: Date
    let endDate: Date
    var dartStatus: [Bool]
    
}
