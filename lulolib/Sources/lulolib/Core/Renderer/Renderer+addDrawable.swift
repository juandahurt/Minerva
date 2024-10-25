//
//  Renderer+addDrawable.swift
//  lulolib
//
//  Created by Juan Hurtado on 23/10/24.
//

import simd

extension Renderer {
    func addDrawable(fromPrimitive primitive: Primitive) {
        let drawable: Drawable
        
        switch primitive {
        case .line(let x1, let y1, let x2, let y2):
            drawable = Line(
                device: GraphicsContext.instance.device,
                posA: [x1, y1, 0],
                posB: [x2, y2, 0]
            )
        case .triangle(let x1, let y1, let x2, let y2, let x3, let y3):
            drawable = Triangle(
                pointA: [x1, y1, 0],
                pointB: [x2, y2, 0],
                pointC: [x3, y3, 0]
            )
        }
        
        vertexBuffer?.copyBytes(
            from: drawable.vertices,
            size: drawable.offset,
            atOffset: currentOffset
        )
        currentOffset += drawable.offset
        drawableContext.appendDrawable(drawable)
    }
}
