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
    let renderer: Renderer
    
    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("GPU not available")
        }
        
        GraphicsContext.load()
        LibrariesContainer.load()
        
        renderer = Renderer()
        
        super.init(frame: .zero, device: device)
        
        translatesAutoresizingMaskIntoConstraints = false
        clearColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        colorPixelFormat = .rgba8Unorm // TODO: maybe save this value globally?
        preferredFramesPerSecond = 60
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRenderer(with commander: RendererCommander) {
        renderer.delegate = self
        delegate = renderer
        commander.subordinate = renderer
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
