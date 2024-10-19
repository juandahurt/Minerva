//
//  RenderPipelineStateLibrary.swift
//  lulolib
//
//  Created by Juan Hurtado on 19/10/24.
//

import Metal

enum RenderPipelineStateType {
    case `default`
}

class RenderPipelineStateLibrary: Library {
    private var dictionary: [RenderPipelineStateType : MTLRenderPipelineState] = [:]
    
    func load() {
        dictionary[.default] = makeDefaultRenderPipelineState()
    }
    
    func getValue(ofKey key: RenderPipelineStateType) -> MTLRenderPipelineState {
        guard let value = dictionary[key] else {
            fatalError("key not found!")
        }
        return value
    }
}

// MARK: - creation
extension RenderPipelineStateLibrary {
    func makeDefaultRenderPipelineState() -> MTLRenderPipelineState {
        let device = GraphicsContext.instance.device
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
        
        guard let renderState = try? device?.makeRenderPipelineState(
            descriptor: pipelineDescriptor
        ) else {
            fatalError("It was not possible to make a render pipeline state")
        }
        return renderState
    }
}
