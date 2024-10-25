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
    
    func render(using encoder: MTLRenderCommandEncoder, context: DrawableContext)
}
