//
//  File.swift
//  
//
//  Created by Juan Hurtado on 13/10/24.
//

import Metal

protocol Drawable {
    var indexBuffer: MTLBuffer? { get }
    var vertexBuffer: MTLBuffer? { get }
    var renderPipelineState: MTLRenderPipelineState { get }
    var primitiveType: MTLPrimitiveType { get }
    
    func render(using encoder: MTLRenderCommandEncoder)
}


extension Drawable {
    func render(using encoder: MTLRenderCommandEncoder) {
        encoder.setVertexBuffer(
            vertexBuffer,
            offset: 0,
            index: 0
        )
        encoder.setRenderPipelineState(renderPipelineState)
        encoder.drawIndexedPrimitives(
            type: primitiveType,
            indexCount: 2,
            indexType: .uint16,
            indexBuffer: indexBuffer!,
            indexBufferOffset: 0
        )
    }
}
