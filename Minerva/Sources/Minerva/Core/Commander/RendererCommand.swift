//
//  RendererCommand.swift
//  Minerva
//
//  Created by Juan Hurtado on 30/10/24.
//

enum ShapeCommand {
    case line(x1: Float, y1: Float, x2: Float, y2: Float)
    case triangle(x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float)
    case rect(x: Float, y: Float, w: Float, h: Float)
}

enum RendererCommand {
    case shape(ShapeCommand)
}
