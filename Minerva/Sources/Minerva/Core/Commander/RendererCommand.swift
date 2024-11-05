//
//  RendererCommand.swift
//  Minerva
//
//  Created by Juan Hurtado on 30/10/24.
//

import simd

enum ShapeCommand {
    case line(x1: Float, y1: Float, x2: Float, y2: Float)
    case triangle(x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float)
    case rect(x: Float, y: Float, w: Float, h: Float)
}

enum ColorCommand {
    case fill(simd_float3)
    case background(simd_float3)
}

enum TransformCommand {
    case translate(simd_float3)
    case rotate(Float)
}

enum StructureCommand {
    case push, pop
}

enum RendererCommand {
    case shape(ShapeCommand)
    case color(ColorCommand)
    case transform(TransformCommand)
    case structure(StructureCommand)
}
