//
//  Renderer+color.swift
//  Minerva
//
//  Created by Juan Hurtado on 29/10/24.
//

import MetalKit

extension Renderer {
    func setClearColor(_ color: MTLClearColor) {
        drawableContext.backgroundColor = color
    }
    
    func setFillColor(_ color: simd_float3) {
        drawableContext.currentDrawingGroup.fillColor = color
    }
}
