//
//  SketchView.swift
//  
//
//  Created by Juan Hurtado on 12/10/24.
//

import MetalKit

class SketchView: MTKView {
    weak var sketch: Sketch?
    private let renderer = Renderer()
    
    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("GPU not available")
        }
        super.init(frame: .zero, device: device)
        
        renderer.context.graphicalContext.device = device // TODO: I don't like this, I need to find a better way to set this
        renderer.delegate = self
        
        translatesAutoresizingMaskIntoConstraints = false
        clearColor = .init(red: 0.2, green: 0.3, blue: 0.2, alpha: 1)
        delegate = renderer
        colorPixelFormat = .rgba8Unorm
        preferredFramesPerSecond = 5
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SketchView {
    func addPrimitive(_ primitive: Primitive) {
        renderer.addDrawable(fromPrimitive: primitive)
    }
}

extension SketchView: RendererDelegate {
    func onDraw() {
        sketch?.draw()
    }
}
