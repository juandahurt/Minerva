//
//  File.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Metal

protocol Drawable {
    var primitiveType: MTLPrimitiveType { get }
    var offset: Int { get }
    var vertexCount: Int { get }
    var vertices: [Vertex] { get }
}
