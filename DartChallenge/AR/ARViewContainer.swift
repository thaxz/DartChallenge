//
//  ARViewContainer.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView()
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
    }
}
