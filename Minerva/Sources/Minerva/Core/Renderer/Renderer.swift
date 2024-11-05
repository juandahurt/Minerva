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
    var currentVertex = 0
    
    weak var delegate: RendererDelegate?
    
    private var uniforms = Uniforms()
    private var setupHasBeenCalled = false
    
    var commands: [RendererCommand] = []
    
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
        
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.setRenderPipelineState(
            LibrariesContainer.renderPipelineStateLibrary.getValue(ofKey: .default)
        )
        
        renderEncoder.setVertexBytes(
            &drawableContext.currentDrawingGroup.fillColor,
            length: MemoryLayout<SIMD3<Float>>.stride,
            index: 11
        )
        
        renderEncoder.setVertexBytes(
            &uniforms,
            length: MemoryLayout<Uniforms>.stride,
            index: 10
        )

        
        delegate?.onDraw()
        
        let viewMatrix = float4x4(translation: [0, -1, 0])
        
        uniforms.viewMatrix = viewMatrix
        
        for command in commands {
            switch command {
            case .shape(let shapeCommand):
                renderEncoder.setVertexBytes(
                    &uniforms,
                    length: MemoryLayout<Uniforms>.stride,
                    index: 10
                )
                let drawable = makeDrawable(from: shapeCommand)
                updateVertexBuffer(using: drawable)
                draw(drawable, using: renderEncoder)
            case .color(let colorCommand):
                handleColorCommand(colorCommand, with: renderEncoder, view: view)
            case .transform(let transformCommand):
                handleTranformCommand(transformCommand, with: renderEncoder)
            case .structure(let structureCommand):
                switch structureCommand {
                case .push:
                    drawableContext.pushNewDrawingGroup()
                case .pop:
                    drawableContext.popDrawingGroup()
                    uniforms.modelMatrix = drawableContext.currentDrawingGroup.modelMatrix
                }
                renderEncoder.setVertexBytes(
                    &uniforms,
                    length: MemoryLayout<Uniforms>.stride,
                    index: 10
                )
                break
                
            }
        }
        
        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        // clear drawable context
        drawableContext.clear()
        currentOffset = 0
        commands = []
        currentVertex = 0
        uniforms.modelMatrix = matrix_identity_float4x4
    }
}

extension Renderer {
    func draw(_ drawable: Drawable, using renderEncoder: MTLRenderCommandEncoder) {
        renderEncoder.drawPrimitives(
            type: drawable.primitiveType,
            vertexStart: currentVertex,
            vertexCount: drawable.vertexCount
        )
        currentVertex += drawable.vertexCount
    }
}


extension Renderer {
    func handleTranformCommand(_ command: TransformCommand, with encoder: MTLRenderCommandEncoder) {
        switch command {
        case .translate(let translation):
            drawableContext.currentDrawingGroup.modelMatrix *= .init(translation: translation)
        case .rotate(let angle):
            drawableContext.currentDrawingGroup.modelMatrix *= .init(rotationZ: angle)
        }
        
        uniforms.modelMatrix = drawableContext.currentDrawingGroup.modelMatrix
        encoder.setVertexBytes(
            &uniforms,
            length: MemoryLayout<Uniforms>.stride,
            index: 10
        )
    }
}
