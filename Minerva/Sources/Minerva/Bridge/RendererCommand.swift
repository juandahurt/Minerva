//
//  RendererCommand.swift
//  Minerva
//
//  Created by Juan Hurtado on 30/10/24.
//

enum ShapeCommand {
    case line(x1: Float, y1: Float, x2: Float, y2: Float)
}

enum RendererCommand {
    case shape(ShapeCommand)
}
