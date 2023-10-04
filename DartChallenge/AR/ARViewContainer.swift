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
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView()
        context.coordinator.arView = arView
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator,action: #selector(Coordinator.viewTapped(_:)))
        tapRecognizer.name = "ARView Tap"
        arView.addGestureRecognizer(tapRecognizer)
        return arView
    }
    
    class Coordinator: NSObject {
        weak var arView: ARView?
        let parent: ARViewContainer
        
        init(parent: ARViewContainer) {
            self.parent = parent
        }

        @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            print("ta tocando aqui \(point)")
            guard let arView = arView else { return }
                
                // Obtendo o centro da tela
                let screenCenter = CGPoint(x: arView.bounds.midX, y: arView.bounds.midY)
                
                // Obtendo a transformação do plano. Neste exemplo, use a identidade para o plano no nível do chão.
                let planeTransform = float4x4.identity
                
                // Desprojeta o ponto do centro da tela para o plano
                if let worldCoord = arView.unproject(screenCenter, ontoPlane: planeTransform) {
                    ARManager.shared.actionsStream.send(.placeDart(at: worldCoord))
                }
        }
    }

    func makeCoordinator() -> ARViewContainer.Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
    }
}

public extension float4x4 {
    static var identity: float4x4 {
        return float4x4(diagonal: float4(1, 1, 1, 1))
    }
}
