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
    var indexBuffer: MTLBuffer?
    var vertexBuffer: MTLBuffer?
    var renderPipelineState: MTLRenderPipelineState
    var primitiveType: MTLPrimitiveType = .line
    
    var indices: [UInt16] = [
        0, 1
    ]
    
    var vertices: [Vertex] = []
    
    init(device: MTLDevice, posA: SIMD3<Float>, posB: SIMD3<Float>) {
        indexBuffer = device.makeBuffer(
            bytes: &indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        )
        vertices = [.init(position: posA), .init(position: posB)]
        vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
        renderPipelineState = LibrariesContainer.renderPipelineStateLibrary.getValue(ofKey: .default)
    }
    
    func render(using encoder: any MTLRenderCommandEncoder, context: DrawableContext) {
        encoder.setVertexBuffer(
            vertexBuffer,
            offset: 0,
            index: 0
        )
        encoder.setRenderPipelineState(renderPipelineState)
        encoder.drawIndexedPrimitives(
            type: primitiveType,
            indexCount: indices.count,
            indexType: .uint16,
            indexBuffer: indexBuffer!,
            indexBufferOffset: 0
        )
    }
}
