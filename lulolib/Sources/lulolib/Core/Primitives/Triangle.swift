//
//  Triangle.swift
//  lulolib
//
//  Created by Juan Hurtado on 24/10/24.
//

import simd
import Metal

class Triangle: Drawable {
    var primitiveType: MTLPrimitiveType = .triangle
    var offset: Int = 0
    var vertexCount: Int = 3
    var vertices: [Vertex] = []
    
    init(pointA: simd_float3, pointB: simd_float3, pointC: simd_float3) {
        vertices = [
            .init(position: pointA),
            .init(position: pointB),
            .init(position: pointC),
        ]
        offset = MemoryLayout<Vertex>.stride * vertexCount
    }
}
