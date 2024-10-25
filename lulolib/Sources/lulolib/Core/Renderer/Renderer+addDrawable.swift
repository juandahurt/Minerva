//
//  Renderer+addDrawable.swift
//  lulolib
//
//  Created by Juan Hurtado on 23/10/24.
//

import simd

extension Renderer {
    func addDrawable(fromPrimitive primitive: Primitive) {
        let offset: Int
        switch primitive {
        case .line(let x1, let y1, let x2, let y2):
            let line = Line(
                device: GraphicsContext.instance.device,
                posA: [x1, y1, 0],
                posB: [x2, y2, 0]
            )
            drawableContext.appendDrawable(line)
            var pointer = vertexBuffer?.contents()
            pointer = pointer?.advanced(by: currentOffset)
            pointer?.copyMemory(
                from: line.vertices,
                byteCount: line.offset
            )
            offset = line.offset
        case .triangle(let x1, let y1, let x2, let y2, let x3, let y3):
            let triangle = Triangle(
                pointA: [x1, y1, 0],
                pointB: [x2, y2, 0],
                pointC: [x3, y3, 0]
            )
            drawableContext.appendDrawable(triangle)
            vertexBuffer?.copyBytes(
                from: triangle.vertices,
                size: triangle.offset,
                atOffset: currentOffset
            )
//            var pointer = vertexBuffer?.contents()
//            pointer?.copyMemory(
//                from: triangle.vertices,
//                byteCount: triangle.offset,
//                atOffset: currentOffset
//            )
//            pointer = pointer?.advanced(by: currentOffset)
//            pointer?.copyMemory(
//                from: triangle.vertices,
//                byteCount: triangle.offset
//            )
            offset = triangle.offset
        }
        currentOffset += offset
    }
}
