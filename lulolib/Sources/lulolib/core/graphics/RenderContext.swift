//
//  GraphicsContext.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Metal

class GraphicsContext {
    var device: MTLDevice? {
        didSet {
            commandQueue = device?.makeCommandQueue()
        }
    }
    var commandQueue: MTLCommandQueue?
}

class DrawableContext {
    private(set) var thingsToDraw: [Drawable] = []
    
    func appendDrawable(_ drawable: Drawable) {
        thingsToDraw.append(drawable)
    }
    
    func clear() { thingsToDraw.removeAll() }
}

class RenderContext {
    var graphicalContext: GraphicsContext = .init()
    var drawableContext: DrawableContext = .init()
}
