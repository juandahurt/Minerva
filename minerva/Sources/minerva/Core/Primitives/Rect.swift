//
//  Rect.swift
//  Minerva
//
//  Created by Juan Hurtado on 26/10/24.
//

import Metal

class Rect: Drawable {
    var primitiveType: MTLPrimitiveType
    var offset: Int
    var vertexCount: Int
    var vertices: [Vertex]
    
    init(x: Float, y: Float, w: Float, h: Float) {
        primitiveType = .triangle
        vertices = [
            // left triangle
            .init(position: [x, y, 0]),
            .init(position: [x, y + h, 0]),
            .init(position: [x + w, y, 0]),
            // right triangle
            .init(position: [x + w, y + h, 0]),
            .init(position: [x + w, y, 0]),
            .init(position: [x, y + h, 0]),
        ]
        vertexCount = vertices.count
        offset = MemoryLayout<Vertex>.size * vertexCount
    }
}
