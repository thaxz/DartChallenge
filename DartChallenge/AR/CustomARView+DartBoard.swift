//
//  CustomARView+DartBoard.swift
//  DartChallenge
//
//  Created by thaxz on 04/10/23.
//

import Foundation

import RealityKit

// MARK: DartBoard logic

extension CustomARView {
    
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
        let randomX = Float.random(in: -1.5...1.5) // Coordenada X entre -5 e 5 metros
        let randomZ = Float.random(in: -2...0)
        return (randomX, randomZ)
    }
    
    
    
    
}
