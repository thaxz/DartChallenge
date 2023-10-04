//
//  CustomARView+Dart.swift
//  DartChallenge
//
//  Created by thaxz on 04/10/23.
//

import Foundation
import RealityKit

// MARK: Dart (Ball) logic

extension CustomARView {
    
    func loadBall(physicalSphere: ModelEntity, at position: SIMD3<Float>) {
        ballWorldAnchor.position = position
        createDartPhysics(physicalSphere: physicalSphere)
        ballWorldAnchor.addChild(physicalSphere)
        self.scene.anchors.append(ballWorldAnchor)
    }
    
    func createDartPhysics(physicalSphere: ModelEntity){
        physicalSphere.physicsBody = PhysicsBodyComponent(massProperties: PhysicsMassProperties(shape: .generateSphere(radius: 0.4), mass: 10.0), material: .generate(),mode: .dynamic)
        physicalSphere.generateCollisionShapes(recursive: false)
        let throwForce = SIMD3<Float>(0, 0, -20)
        let motionComponent = PhysicsMotionComponent(linearVelocity: throwForce, angularVelocity: [0, 0, 0])
        physicalSphere.components.set(motionComponent)
    }
    
    func updateDart(){
        if (self.ballEntity.transform.translation.y) < -2.0 {
            scene.removeAnchor(ballWorldAnchor)
        }
    }
    
}
