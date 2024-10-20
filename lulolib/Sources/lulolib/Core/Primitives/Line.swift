//
//  Line.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Foundation
import Metal

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
    
    var vertices: [Vertex] = [
        .init(position: [0,0,0]),
        .init(position: [0,0.5,0]),
    ]
    
    init(device: MTLDevice) {
        indexBuffer = device.makeBuffer(
            bytes: &indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        )
        vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
        renderPipelineState = LibrariesContainer.renderPipelineStateLibrary.getValue(ofKey: .default)
    }
    
    func render(using encoder: any MTLRenderCommandEncoder) {
        let pointer = vertexBuffer!.contents()
        let newVertex = Vertex(position: [vertices[1].position.x, 0, 0])
        vertices[1].position.x += .random(in: 0..<0.1)
//        pointer.storeBytes(
//            of: newVertex.position,
//            toByteOffset: MemoryLayout<Vertex>.stride,
//            as: SIMD3<Float>.self
//        )
        
        print(pointer.load(as: SIMD3<Float>.self))
        
//        let vertices = pointer.load(as: [Vertex].self)
//        print(vertices)
        vertexBuffer = GraphicsContext.instance.device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
        
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
