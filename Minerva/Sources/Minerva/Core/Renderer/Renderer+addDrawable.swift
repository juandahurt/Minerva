//
//  Renderer+addDrawable.swift
//  Minerva
//
//  Created by Juan Hurtado on 23/10/24.
//

import simd

extension Renderer {
    func updateVertexBuffer(using drawable: Drawable) {
        vertexBuffer?.copyBytes(
            from: drawable.vertices,
            size: drawable.offset,
            atOffset: currentOffset
        )
        currentOffset += drawable.offset
    }
    
    func makeDrawable(from command: ShapeCommand) -> Drawable {
        let drawable: Drawable
        
        switch command {
        case .line(let x1, let y1, let x2, let y2):
            drawable = Line(
                posA: [x1, y1, 0],
                posB: [x2, y2, 0]
            )
        case .triangle(let x1, let y1, let x2, let y2, let x3, let y3):
            drawable = Triangle(
                pointA: [x1, y1, 0],
                pointB: [x2, y2, 0],
                pointC: [x3, y3, 0]
            )
        case .rect(let x, let y, let w, let h):
            drawable = Rect(
                x: x,
                y: y,
                w: w,
                h: h
            )
        }
        
        return drawable
    }
}
