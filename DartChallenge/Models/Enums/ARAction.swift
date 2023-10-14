//
//  ARAction.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI

enum ARAction {
    
    case placeDart(at: SIMD3<Float>)
    case placeBoard
    case removeDart
    case checkCollision
    case pause
    case play
}
