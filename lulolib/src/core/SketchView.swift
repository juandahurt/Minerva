//
//  SketchView.swift
//  
//
//  Created by Juan Hurtado on 12/10/24.
//

import MetalKit

class SketchView: MTKView {
    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("GPU not available")
        }
        super.init(frame: .zero, device: device)
        translatesAutoresizingMaskIntoConstraints = false
        clearColor = .init(red: 0.2, green: 0.3, blue: 0.2, alpha: 1)
        delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SketchView: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let commandQueue = device?.makeCommandQueue(),
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderDescriptor = view.currentRenderPassDescriptor,
              let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor)
        else {
            return
        }
        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
