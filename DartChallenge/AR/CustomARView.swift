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

class CustomARView: ARView {
    
    private var cancellables: Set<AnyCancellable> = []
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This is the init that is being used
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        subscribeToActionStream()
    }
    
    // View's configuration
    private func setupConfiguration(){
        // Tracks the device relative to it's environment
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
    }
    
    func subscribeToActionStream(){
        ARManager.shared.actionsStream
        // subscribing with sink
            .sink { [weak self] action in
                // switching according to each action
                switch action {
                case .placeDart:
                    self?.placeDart()
                case .placeBoard:
                    self?.placeBoard()
                }
            }
            .store(in: &cancellables)
    }
    
    // Mock object placed in the scene
    func placeBlock(){
        // Creating entity
        let block = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: UIColor.blue, isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        // Connecting with anchor
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        // Adding to the scene
        scene.addAnchor(anchor)
    }
    
    func placeDart(){
        let anchor = AnchorEntity(plane: .horizontal)
        guard let dartEntity = try? Entity.load(named: "firstDart") else {return}
        anchor.addChild(dartEntity)
        scene.addAnchor(anchor)
        
    }
    
    func placeBoard(){
        // Place 1m left, 1m above, and 2m away from the origin of the parent entity
        let anchor = AnchorEntity(world: [-1,0,-2])
        guard let boardEntity = try? Entity.load(named: "dartBoard") else {return}
        anchor.addChild(boardEntity)
        scene.addAnchor(anchor)
    }
  
}
