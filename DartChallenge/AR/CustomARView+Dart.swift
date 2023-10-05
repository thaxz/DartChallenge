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
    
    func loadDart(physicalSphere: ModelEntity, at position: SIMD3<Float>) {
            dartWorldAnchor.position = position
            //physics
        physicalSphere.physicsBody = PhysicsBodyComponent(massProperties: PhysicsMassProperties(shape: .generateBox(width: 1, height: 1, depth: 2), mass: 10.0), material: .generate(),mode: .dynamic)
            physicalSphere.generateCollisionShapes(recursive: false)
            
        //todo: make more ranges
            var throwDirection: SIMD3<Float> = [0, 0, -40]
            switch position {
            case let p where p.x < -0.5:
                throwDirection = [-1, 0, 0]
            case let p where p.x > 0.5:
                throwDirection = [1, 0, 0]
            case let p where p.z < -0.5:
                throwDirection = [0, 0, -1]
            case let p where p.z > 0.5:
                throwDirection = [0, 0, 1]
            default:
                break
            }
            
            throwDirection = simd_normalize(throwDirection)
            let throwForce = throwDirection * 40
            
            let motionComponent = PhysicsMotionComponent(linearVelocity: throwForce, angularVelocity: [0, 0, 0])
            physicalSphere.components.set(motionComponent)
            
            //add
            dartWorldAnchor.addChild(physicalSphere)
            self.scene.anchors.append(dartWorldAnchor)
        }
    
    
    func updateDart(){
        if (self.dartEntity.transform.translation.y) < -2.0 {
            scene.removeAnchor(dartWorldAnchor)
            dartEntity = ModelEntity(mesh: .generateBox(width: 1, height: 1, depth: 2),
                                     materials: [SimpleMaterial(color: .red, isMetallic: false)])
            dartWorldAnchor = AnchorEntity()
        }
    }
    
}
