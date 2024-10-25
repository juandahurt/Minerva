//
//  File.swift
//  
//
//  Created by Juan Hurtado on 13/10/24.
//

import Foundation

public extension Sketch {
    func line(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) {
        view.addPrimitive(.line(x1: x1, y1: y1, x2: x2, y2: y2))
    }
    
    func triangle(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float, _ x3: Float, _ y3: Float) {
        view.addPrimitive(.triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3))
    }
}
