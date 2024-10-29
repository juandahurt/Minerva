//
//  Primitives.swift
//
//
//  Created by Juan Hurtado on 13/10/24.
//

import Foundation

public enum Primitive {
    case line(x1: Float, y1: Float, x2: Float, y2: Float)
    case triangle(x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float)
    case rect(x: Float, y: Float, w: Float, h: Float)
}
