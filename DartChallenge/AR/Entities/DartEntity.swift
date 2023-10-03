//
//  DartEntity.swift
//  DartChallenge
//
//  Created by thaxz on 03/10/23.
//

import Foundation
import Combine
import RealityKit

final class DartEntity: Entity {
    var dartModel: Entity?
    
    static var loadAsync: AnyPublisher<DartEntity, Error> {
        return Entity.loadAsync(named: "firstDart")
            .map { loadedDart -> DartEntity in
                let dart = DartEntity()
                loadedDart.name = "firstDart"
                dart.dartModel = loadedDart
                dart.generateCollisionShapes(recursive: true)
                let physics = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .dynamic)
                dart.components.set(physics)
                return dart
            }
            .eraseToAnyPublisher()
    }
    
}
