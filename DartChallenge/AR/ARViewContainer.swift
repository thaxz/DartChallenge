//
//  ARViewContainer.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    var coordinator: Coordinator
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView()
        coordinator.arView = arView
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}

class Coordinator: ObservableObject {
    weak var arView: CustomARView?
    
    func placeDart() {
        guard let arView = arView else { return }
        let screenCenter = CGPoint(x: arView.bounds.midX, y: arView.bounds.midY)
        let planeTransform = float4x4.identity
        if let worldCoord = arView.unproject(screenCenter, ontoPlane: planeTransform) {
            ARManager.shared.actionsStream.send(.placeDart(at: worldCoord))
        }
    }
}


