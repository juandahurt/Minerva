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
    var drawableContext = DrawableContext()
    weak var delegate: RendererDelegate?
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
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
        
        delegate?.onDraw()
        for drawable in drawableContext.thingsToDraw {
            drawable.render(using: renderEncoder)
        }
        
        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
        // clear drawable context
        drawableContext.clear()
    }
}


extension Renderer {
    func addDrawable(fromPrimitive primitive: Primitive) {
        switch primitive {
        case .line:
            drawableContext.appendDrawable(LibrariesContainer.drawableLibrary.getValue(ofKey: .line))
        }
    }
}
