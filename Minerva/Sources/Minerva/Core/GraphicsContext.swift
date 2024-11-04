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

protocol Transformable {
    var translation: simd_float3 { get }
    var rotation: Float { get } // rotation on the z axis
    var modelMatrix: float4x4 { get }
}

class DrawingGroup: Transformable {
    var fillColor: simd_float3 = .zero
    var translation: simd_float3 = .zero
    var rotation: Float = .zero
    var modelMatrix: float4x4 {
        matrix_identity_float4x4 * .init(translation: translation) * .init(rotationZ: rotation)
    }
    
    init(fillColor: simd_float3, translation: simd_float3, rotation: Float) {
        self.fillColor = fillColor
        self.translation = translation
        self.rotation = rotation
    }
    
    init() {
        
    }
}

class DrawableContext {
    var drawingGroups: [DrawingGroup] = []
    var backgroundColor: MTLClearColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
    var canvasSize: CGSize = .zero
    var currentDrawingGroup: DrawingGroup {
        get {
            if drawingGroups.isEmpty {
                drawingGroups.append(.init())
            }
            return drawingGroups.last! // TODO: add guard here?
        }
        set {}
    }
    
    func pushNewDrawingGroup() {
        drawingGroups.append(
            .init(
                fillColor: currentDrawingGroup.fillColor,
                translation: currentDrawingGroup.translation,
                rotation: currentDrawingGroup.rotation
            )
        )
    }
    
    func popDrawingGroup() {
        guard !drawingGroups.isEmpty else { return }
        drawingGroups.pop()
    }
    
    func clear() {
        drawingGroups = []
    }
}

extension Array where Element: DrawingGroup {
    mutating func pop() {
        let _ = popLast()
    }
}
