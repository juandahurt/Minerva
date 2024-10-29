//
//  Renderer.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import MetalKit

protocol RendererDelegate: AnyObject {
    func onSetup()
    func onDraw()
    func viewSizeChanged(size: CGSize)
}

struct Uniforms {
    var modelMatrix: float4x4 = matrix_identity_float4x4
    var viewMatrix: float4x4 = matrix_identity_float4x4
    var projectionMatrix: float4x4 = matrix_identity_float4x4
}

class Renderer: NSObject, MTKViewDelegate {
    var drawableContext = DrawableContext()
    
    var vertexBuffer: MTLBuffer?
    var currentOffset = 0
    
    weak var delegate: RendererDelegate?
    
    private var uniforms = Uniforms()
    private var setupHasBeenCalled = false
    
    override init() {
        super.init()
        let size = GraphicsContext.instance.device.maxBufferLength
        vertexBuffer = GraphicsContext.instance.device.makeBuffer(length: size)
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        drawableContext.canvasSize = size
        delegate?.viewSizeChanged(size: size)
        
        let rect = CGRect(
            x: 0,
            y: 0,
            width: size.width,
            height: size.height
        )
        let projectionMatrix = float4x4(
            orthographic: rect,
            near: 0,
            far: 10
        )
        
        uniforms.projectionMatrix = projectionMatrix
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
        
        if !setupHasBeenCalled { delegate?.onSetup(); setupHasBeenCalled = true }
        
        view.clearColor = drawableContext.backgroundColor
        
        let viewMatrix = float4x4(translation: [0, -1, 0])
        
        uniforms.viewMatrix = viewMatrix
        
        renderEncoder.setVertexBytes(
            &uniforms,
            length: MemoryLayout<Uniforms>.stride,
            index: 10
        )
    
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.setRenderPipelineState(
            LibrariesContainer.renderPipelineStateLibrary.getValue(ofKey: .default)
        )
        delegate?.onDraw()
        
        for drawingGroup in drawableContext.drawingGroups {
            // TODO: make sure the line primitive doesn't use the fill color
            renderEncoder.setVertexBytes(
                &drawableContext.currentDrawingGroup.fillColor,
                length: MemoryLayout<SIMD3<Float>>.stride,
                index: 11
            )
            
            var currentVertex = 0
            for drawable in drawingGroup.drawables {
                renderEncoder.drawPrimitives(
                    type: drawable.primitiveType,
                    vertexStart: currentVertex,
                    vertexCount: drawable.vertexCount
                )
                currentVertex += drawable.vertexCount
            }
        }
        
        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        // clear drawable context
        drawableContext.clear()
        currentOffset = 0
    }
}
