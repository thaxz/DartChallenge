//
//  CustomARView+Load.swift
//  DartChallenge
//
//  Created by thaxz on 03/10/23.
//

import Foundation
import RealityKit

extension CustomARView {
    
    func loadUsdz(file: String, worldAnchor: AnchorEntity) {
        let entity = try! ModelEntity.load(named: file)
        worldAnchor.addChild(entity)
        self.scene.anchors.append(worldAnchor)
    }
    
    
}

