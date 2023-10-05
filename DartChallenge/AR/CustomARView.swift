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
    
    // MARK: INITS
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This is the init that is being used
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: COMPONENTS
    var dartBoard: Entity?
    var dartEntity = ModelEntity(mesh: .generateBox(width: 1, height: 1, depth: 9),
                                 materials: [SimpleMaterial(color: .red, isMetallic: false)])
    var dartWorldAnchor = AnchorEntity()
    
    
    
    // View's configuration
    private func setupConfiguration(){
        // Tracks the device relative to it's environment
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
    }
    
    func subscribeToActionStream(){
        ARManager.shared.actionsStream
            .sink { [weak self] action in
                switch action {
                case .placeDart(let position):
                    self?.loadDart(physicalSphere: self!.dartEntity, at: position)
                case .placeBoard:
                    self?.placeBoard()
                case .removeDart:
                    self?.updateDart()
                }
            }
            .store(in: &cancellables)
    }
    
    // Mock object placed in the scene
    func placeBlock(){
        let box = CustomBox(color: .yellow, position: [-0.6, -1, -2])
        self.installGestures(.all, for: box)
        box.generateCollisionShapes(recursive: true)
        self.scene.anchors.append(box)
        // installing gestures
        self.installGestures(.init(arrayLiteral: [.rotation, .scale]), for: box)
    }
    
}
