//
//  Renderer.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import MetalKit

protocol RendererDelegate: AnyObject {
    func onDraw()
}

struct Uniforms {
    var modelMatrix: float4x4 = matrix_identity_float4x4
    var viewMatrix: float4x4 = matrix_identity_float4x4
    var projectionMatrix: float4x4 = matrix_identity_float4x4
}

class Renderer: NSObject, MTKViewDelegate {
    var drawableContext = DrawableContext()
    weak var delegate: RendererDelegate?
    
    var uniforms = Uniforms()
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        drawableContext.canvasSize = size
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let commandQueue = GraphicsContext.instance.commandQueue,
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else {
            return
        }
        
        let canvasSize = drawableContext.canvasSize
        let aspect = canvasSize.width / canvasSize.height
        let rect = CGRect(
            x: 0,
            y: 0,
            width: canvasSize.width,
            height: aspect * canvasSize.height
        )
        let projectionMatrix = float4x4(
            orthographic: rect,
            near: 0,
            far: 10
        )
        
        let viewMatrix = float4x4(translation: [0, -1, 0])
        
        uniforms.projectionMatrix = projectionMatrix
        uniforms.viewMatrix = viewMatrix
        
        renderEncoder.setVertexBytes(
            &uniforms,
            length: MemoryLayout<Uniforms>.stride,
            index: 10
        )
        
        delegate?.onDraw()
        for drawable in drawableContext.thingsToDraw {
            drawable.render(using: renderEncoder, context: drawableContext)
        }
        
        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        // clear drawable context
        drawableContext.clear()
        
//        view.isPaused = true
    }
}
