//
//  Sketch+color.swift
//  Minerva
//
//  Created by Juan Hurtado on 29/10/24.
//

public extension Sketch {
    func background(_ r: Float, _ g: Float, _ b: Float) {
        rendererCommander.pushCommand(
            .color(
                .background([r, g, b])
            )
        )
    }
    
    func fill(_ r: Float, _ g: Float, _ b: Float) {
        rendererCommander.pushCommand(
            .color(
                .fill([r, g, b])
            )
        )
    }
}
