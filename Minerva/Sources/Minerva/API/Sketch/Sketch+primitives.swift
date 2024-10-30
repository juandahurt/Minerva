//
//  File.swift
//  
//
//  Created by Juan Hurtado on 13/10/24.
//

import Foundation

public extension Sketch {
    func line(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) {
        rendererCommander.pushCommand(
            .shape(
                .line(
                    x1: x1,
                    y1: y1,
                    x2: x2,
                    y2: y2
                )
            )
        )
    }
    
    func triangle(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float, _ x3: Float, _ y3: Float) {
        rendererCommander.pushCommand(
            .shape(
                .triangle(
                    x1: x1,
                    y1: y1,
                    x2: x2,
                    y2: y2,
                    x3: x3,
                    y3: y3
                )
            )
        )
    }
    
    func rect(x: Float, y: Float, w: Float, h: Float) {
        rendererCommander.pushCommand(
            .shape(
                .rect(
                    x: x,
                    y: y,
                    w: w,
                    h: h
                )
            )
        )
    }
}
