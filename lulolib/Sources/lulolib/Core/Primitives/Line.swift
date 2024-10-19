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
    var renderPipelineState: MTLRenderPipelineState
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
        renderPipelineState = LibrariesContainer.renderPipelineStateLibrary.getValue(ofKey: .default)
    }
}

extension Line {
    static let instance: Line = {
        Line(device: MTLCreateSystemDefaultDevice()!)
    }()
}
