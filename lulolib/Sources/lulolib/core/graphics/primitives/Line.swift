//
//  Line.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Foundation
import Metal

class Line: Drawable {
    var indexBuffer: MTLBuffer?
    var vertexBuffer: MTLBuffer?
    var renderState: MTLRenderPipelineState
    var primitiveType: MTLPrimitiveType = .line
    
    var indices: [UInt16] = [
        0, 1
    ]
    
    var vertices: [Float] = [
        0, 0, 0,
        0.5, 0.5, 0
    ]
    
    init(device: MTLDevice) {
        indexBuffer = device.makeBuffer(
            bytes: &indices,
            length: MemoryLayout<Float>.stride * indices.count
        )
        vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Float>.stride * vertices.count
        )
        self.renderState = Test.pipelineState
    }
}

extension Line {
    static let instance: Line = {
        Line(device: MTLCreateSystemDefaultDevice()!)
    }()
}


class Test {
    static let pipelineState: MTLRenderPipelineState = {
        let device = MTLCreateSystemDefaultDevice()
        let lib = try? device?.makeDefaultLibrary(bundle: Bundle.module)
        let vertexFunction = lib?.makeFunction(name: "vertex_shader")
        let fragmentFunction = lib?.makeFunction(name: "fragment_shader")
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Float>.stride * 3
        
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.colorAttachments[0].pixelFormat = .rgba8Unorm
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        
        guard let renderState = try? device?.makeRenderPipelineState(descriptor: pipelineDescriptor) else {
            fatalError("??")
        }
        return renderState
    }()
}
