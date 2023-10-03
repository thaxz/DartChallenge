//
//  Entity.swift
//  DartChallenge
//
//  Created by thaxz on 03/10/23.
//

import Foundation
import RealityKit

extension Entity {
    func addPhysicsToChildren() -> [ModelEntity] {
        if let modelEntity = self as? ModelEntity {
            if modelEntity.name == "Mesh" {
                modelEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, // mass
                                                               material: .generate(friction: 0.1, // Coefficient of friction
                                                                                   restitution: 0.1), // Conservation rate of kinetic energy of collision
                                                               mode: .dynamic)
                // Attach a physical body in .kinematic mode
                modelEntity.generateCollisionShapes(recursive: false)
                
            }
            return [modelEntity]
        } else {
            var aux: [ModelEntity] = []
            for x in (self.children) {
                let foundChildren = x.addPhysicsToChildren()
                aux.append(contentsOf: foundChildren)
            }
            return aux
        }
    }
}
