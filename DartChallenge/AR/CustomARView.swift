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
    var ballEntity = ModelEntity(mesh: .generateSphere(radius: 0.2),
                                 materials: [SimpleMaterial(color: .white, isMetallic: false)])
    var ballWorldAnchor = AnchorEntity()
    
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
            .sink { [weak self] action in
                // switching according to each action
                switch action {
                case .placeDart(let position):
                    self?.loadBall(physicalSphere: self!.ballEntity, at: position)
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
    
    func loadBall(physicalSphere: ModelEntity, at position: SIMD3<Float>) {
        ballWorldAnchor.position = position
        
        physicalSphere.physicsBody = PhysicsBodyComponent(massProperties: PhysicsMassProperties(shape: .generateSphere(radius: 0.4), mass: 10.0),
                                                          material: .generate(),
                                                          mode: .dynamic)
        physicalSphere.generateCollisionShapes(recursive: false)
        
        let throwForce = SIMD3<Float>(0, 0, -20)
        let motionComponent = PhysicsMotionComponent(linearVelocity: throwForce, angularVelocity: [0, 0, 0])
        physicalSphere.components.set(motionComponent)
        
        ballWorldAnchor.addChild(physicalSphere)
        self.scene.anchors.append(ballWorldAnchor)
    }
    
    func updateDart(){
        if (self.ballEntity.transform.translation.y) < -2.0 {
            scene.removeAnchor(ballWorldAnchor)
        }
    }
    
    func placeDart(){
        let anchor = AnchorEntity(plane: .horizontal)
        guard let dartEntity = try? Entity.load(named: "firstDart") else {return}
        dartEntity.addPhysicsToChildren()
        anchor.addChild(dartEntity)
        scene.addAnchor(anchor)
        
    }
    
    func throwDart() {
        // dont know
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

extension simd_float4x4 {
    var translation: SIMD3<Float> {
        get {
            return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
        }
        set (newValue) {
            columns.3.x = newValue.x
            columns.3.y = newValue.y
            columns.3.z = newValue.z
        }
    }
}
