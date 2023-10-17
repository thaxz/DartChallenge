//
//  ARViewContainer.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI
import ARKit

struct ARViewRepresentable: UIViewRepresentable {
    
    let arDelegate: ARDelegate
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARSCNView(frame: .zero)
        arDelegate.setARView(arView)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
