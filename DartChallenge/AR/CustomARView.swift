//
//  CustomARView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

class ARDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    
    @Published var message:String = "starting AR"
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        
        arView.delegate = self
        arView.scene = SCNScene()
    }

    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("camera did change \(camera.trackingState)")
        switch camera.trackingState {
        case .limited(_):
            message = "tracking limited"
        case .normal:
            message =  "tracking ready"
        case .notAvailable:
            message = "cannot track"
        }
    }
    
    // MARK: - Private

    private var arView: ARSCNView?

    
    

}
