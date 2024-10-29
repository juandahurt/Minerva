//
//  Renderer+color.swift
//  Minerva
//
//  Created by Juan Hurtado on 29/10/24.
//

import Metal

extension Renderer {
    func setClearColor(_ color: MTLClearColor) {
        drawableContext.backgroundColor = color
    }
}
