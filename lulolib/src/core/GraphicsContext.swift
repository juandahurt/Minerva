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
