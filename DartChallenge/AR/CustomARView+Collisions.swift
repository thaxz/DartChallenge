//
//  CustomARView+Collisions.swift
//  DartChallenge
//
//  Created by thaxz on 05/10/23.
//

import Foundation
import RealityKit

// Collisions logic

extension CustomARView {
    
    func checkCollisions(){
        guard let boardEntity = dartBoard else { return }
        if (self.dartEntity.transform.translation) == (boardEntity.transform.translation){
            
            print("colidiu")
        }
    }
    
    
    
    
}
