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

class Renderer: NSObject, MTKViewDelegate {
    var context = RenderContext()
    weak var delegate: RendererDelegate?
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let commandQueue = context.graphicalContext.commandQueue,
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else {
            return
        }
        
        delegate?.onDraw()
        for drawable in context.drawableContext.thingsToDraw {
            drawable.render(using: renderEncoder)
        }
        
        renderEncoder.endEncoding()
        commandBuffer.present(drawable, atTime: 1.0 / Double(view.preferredFramesPerSecond))
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
        
        // clear drawable context
        context.drawableContext.clear()
        
        view.isPaused = true
    }
}


extension Renderer {
    func addDrawable(fromPrimitive primitive: Primitive) {
        guard let device = context.graphicalContext.device else {
            fatalError("graphical context does not have a reference to the GPU")
        }
        switch primitive {
        case .line:
            context.drawableContext.appendDrawable(Line.instance)
        }
    }
}
