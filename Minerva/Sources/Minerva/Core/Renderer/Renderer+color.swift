//
//  Renderer+color.swift
//  Minerva
//
//  Created by Juan Hurtado on 29/10/24.
//

import MetalKit

extension Renderer {
    func handleColorCommand(_ command: ColorCommand, with encoder: MTLRenderCommandEncoder, view: MTKView) {
        switch command {
        case .fill(let color):
            let r = color.x / 255
            let g = color.y / 255
            let b = color.z / 255
            drawableContext.currentDrawingGroup.fillColor = [r, g, b]
            
            encoder.setVertexBytes(
                &drawableContext.currentDrawingGroup.fillColor,
                length: MemoryLayout<SIMD3<Float>>.stride,
                index: 11
            )
        case .background(let color):
            let r = Double(color.x / 255)
            let g = Double(color.y / 255)
            let b = Double(color.z / 255)
            view.clearColor = .init(red: r, green: g, blue: b, alpha: 1)
        }
    }
}
