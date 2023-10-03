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
    
    //MARK: COMPONENTS
    private var dartBoard: Entity?
    
    // This is the init that is being used
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        placeDart()
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
                    self?.throwDart()
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
        let anchor = AnchorEntity(world: [0, 0, 0])
        guard let dartEntity = try? Entity.load(named: "firstDart") else {return}
        anchor.addChild(dartEntity)
        scene.addAnchor(anchor)
        
    }
    
    func throwDart(){
        
    }
    
    func placeBoard() {
        // Remove o "board" anterior se existir algum
        removePreviousBoard()
        
        // Obtém uma posição aleatória para o novo "board"
        let randomPosition = getRandomPosition()
        
        // Cria um novo "board" na posição aleatória, mantendo a altura constante
        let anchor = AnchorEntity(world: [randomPosition.x, 0, randomPosition.z])
        guard let boardEntity = try? Entity.load(named: "dartBoard") else { return }
        let collisionShape = ShapeResource.generateCapsule(height: 0.5, radius: 0.25)
        boardEntity.components.set(CollisionComponent(shapes: [collisionShape]))
        anchor.addChild(boardEntity)
        anchor.name = "dartBoard"
        scene.addAnchor(anchor)
        
        // Armazena a referência ao "board" para acesso posterior
        dartBoard = boardEntity
    }
    
    private func removePreviousBoard() {
        for anchor in scene.anchors {
            if let anchorEntity = anchor as? AnchorEntity, anchorEntity.name == "dartBoard" {
                scene.removeAnchor(anchorEntity)
            }
        }
    }
    
    private func getRandomPosition() -> (x: Float, z: Float) {
        let randomX = Float.random(in: -3...3) // Coordenada X entre -5 e 5 metros
        let randomZ = Float.random(in: -3...0) // Coordenada Z entre -5 e 5 metros
        return (randomX, randomZ)
    }
    
}
