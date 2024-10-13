//
//  Line.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Metal

class Line: Drawable {
    var vertexBuffer: MTLBuffer?
    var renderState: MTLRenderPipelineState
    var primitiveType: MTLPrimitiveType = .line
    
    var vertices: [Float] = [
        0, 0, 0.5, 0.5
    ]
    
    init(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Float>.stride * vertices.count
        )
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
        
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.colorAttachments[0].pixelFormat = .rgba8Unorm
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        renderState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
}
