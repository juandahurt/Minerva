//
//  Triangle.swift
//  lulolib
//
//  Created by Juan Hurtado on 24/10/24.
//

import simd
import Metal

class Triangle: Drawable {
    var indexBuffer: (any MTLBuffer)?
    var vertexBuffer: (any MTLBuffer)?
    var renderPipelineState: any MTLRenderPipelineState = LibrariesContainer.renderPipelineStateLibrary.getValue(ofKey: .default)
    var primitiveType: MTLPrimitiveType = .triangle
    
    private var vertices: [Vertex] = []
    
    init(pointA: simd_float3, pointB: simd_float3, pointC: simd_float3) {
        vertices = [
            .init(position: pointA),
            .init(position: pointB),
            .init(position: pointC),
        ]
        vertexBuffer = GraphicsContext.instance.device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
    }
    
    func render(using encoder: any MTLRenderCommandEncoder, context: DrawableContext) {
        encoder.setVertexBuffer(
            vertexBuffer,
            offset: 0,
            index: 0
        )
        encoder.setRenderPipelineState(renderPipelineState)
        encoder.drawPrimitives(
            type: primitiveType,
            vertexStart: 0,
            vertexCount: 3
        )
    }
}
