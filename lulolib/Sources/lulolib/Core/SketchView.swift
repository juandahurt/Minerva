//
//  SketchView.swift
//  
//
//  Created by Juan Hurtado on 12/10/24.
//

import Combine
import MetalKit

class SketchView: MTKView {
    weak var sketch: Sketch?
    private let renderer: Renderer
    
    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("GPU not available")
        }
        
        GraphicsContext.load()
        LibrariesContainer.load()
        
        renderer = Renderer()
        
        super.init(frame: .zero, device: device)
        
        renderer.delegate = self
        
        translatesAutoresizingMaskIntoConstraints = false
        clearColor = .init(red: 0.2, green: 0.3, blue: 0.2, alpha: 1) // TODO: remove
        delegate = renderer
        colorPixelFormat = .rgba8Unorm // TODO: maybe save this value globally?
        preferredFramesPerSecond = 60
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
    func viewSizeChanged(size: CGSize) {
        sketch?.height = Float(size.height)
        sketch?.width = Float(size.width)
    }
    
    func onDraw() {
        sketch?.draw()
    }
    
    func onSetup() {
        sketch?.setup()
    }
}
