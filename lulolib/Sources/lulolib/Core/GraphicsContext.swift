//
//  GraphicsContext.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import MetalKit

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

class DrawingGroup {
    var drawables: [Drawable] = []
    var backgroundColor: simd_float3 = .zero
    
    func appendDrawable(_ drawable: Drawable) {
        drawables.append(drawable)
    }
}

class DrawableContext {
    var drawingGroups: [DrawingGroup] = []
    
    var canvasSize: CGSize = .zero
    var currentDrawingGroup: DrawingGroup {
        get {
            if drawingGroups.isEmpty {
                drawingGroups.append(.init())
            }
            return drawingGroups[0] // TODO: add guard here?
        }
        set {}
    }
    
    func clear() {
        drawingGroups.removeAll()
    }
}

