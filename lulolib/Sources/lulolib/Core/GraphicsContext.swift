//
//  GraphicsContext.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Metal

class GraphicsContext {
    private init() {}
    
    static let instance = GraphicsContext()
    
    private(set) var device: MTLDevice!
    private(set) var commandQueue: MTLCommandQueue!
    
    static func load() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("GPU not available!")
        }
        instance.device = device
        instance.commandQueue = device.makeCommandQueue()
    }
}

class DrawableContext {
    var canvasSize: CGSize = .zero
    private(set) var thingsToDraw: [Drawable] = []
    
    func appendDrawable(_ drawable: Drawable) {
        thingsToDraw.append(drawable)
    }
    
    func clear() { thingsToDraw.removeAll() }
}
