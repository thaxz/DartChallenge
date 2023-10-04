//
//  Simd_float.swift
//  DartChallenge
//
//  Created by thaxz on 04/10/23.
//

import Foundation
import RealityKit

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

public extension float4x4 {
    static var identity: float4x4 {
        return float4x4(diagonal: float4(1, 1, 1, 1))
    }
}
