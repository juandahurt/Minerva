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
    }
}

extension float4x4 {
    init(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) {
        let X = simd_float4(2 / (right - left), 0, 0, 0)
        let Y = simd_float4(2 / (top - bottom), 0, 0, 0)
        let Z = simd_float4(0, 0, 1 / (far - near), 0)
        let W = simd_float4(
            (left + right) / (left - right),
            (top + bottom) / (bottom - top),
            near / (near - far),
            1)
        
        self.init()
        columns = (X, Y, Z, W)
    }
    
    init(orthographic rect: CGRect, near: Float, far: Float) {
        let left = Float(rect.origin.x)
        let right = Float(rect.origin.x + rect.width)
        let top = Float(rect.origin.y)
        let bottom = Float(rect.height)
        let X = float4(2 / (right - left), 0, 0, 0)
        let Y = float4(0, 2 / (top - bottom), 0, 0)
        let Z = float4(0, 0, 1 / (far - near), 0)
        let W = float4(
            (left + right) / (left - right),
            (top + bottom) / (bottom - top),
            near / (near - far),
            1)
        self.init()
        columns = (X, Y, Z, W)
    }
    
    init(translation: float3) {
        let matrix = float4x4(
            [            1,             0,             0, 0],
            [            0,             1,             0, 0],
            [            0,             0,             1, 0],
            [translation.x, translation.y, translation.z, 1]
        )
        self = matrix
    }
}
