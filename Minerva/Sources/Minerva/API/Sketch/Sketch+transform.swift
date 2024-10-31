//
//  Sketch+transform.swift
//  Minerva
//
//  Created by Juan Hurtado on 30/10/24.
//

public extension Sketch {
    func translate(_ x: Float, _ y: Float) {
        rendererCommander.pushCommand(
            .transform(.translate([x, y, 0]))
        )
    }
}
