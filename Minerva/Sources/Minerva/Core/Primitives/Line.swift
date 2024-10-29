//
//  Line.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Foundation
import Metal

// TOOD: move to a common header file (?)
struct Vertex {
    var position: SIMD3<Float> = .zero
}

class Line: Drawable {
    var primitiveType: MTLPrimitiveType = .line
    var offset: Int = 0
    var vertexCount: Int = 2
    
    var vertices: [Vertex] = []
    
    init(posA: SIMD3<Float>, posB: SIMD3<Float>) {
        vertices = [.init(position: posA), .init(position: posB)]
        offset = MemoryLayout<Vertex>.stride * vertexCount
    }
}
