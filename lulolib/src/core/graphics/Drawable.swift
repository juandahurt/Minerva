//
//  File.swift
//  
//
//  Created by Juan Hurtado on 13/10/24.
//

import Metal

protocol Drawable {
    var vertexBuffer: MTLBuffer? { get }
    var renderState: MTLRenderPipelineState { get }
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
        encoder.setRenderPipelineState(renderState)
        encoder.drawPrimitives(
            type: primitiveType,
            vertexStart: 0,
            vertexCount: 4 // TODO: remove mock value
        )
    }
}
