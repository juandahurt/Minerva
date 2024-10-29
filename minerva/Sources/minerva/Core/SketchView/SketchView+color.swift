//
//  SketchView+color.swift
//  Minerva
//
//  Created by Juan Hurtado on 29/10/24.
//

extension SketchView {
    func setClearColor(_ r: Float, _ g: Float, _ b: Float) {
        renderer.setClearColor(
            .init(
                red: Double(r / 255),
                green: Double(g / 255),
                blue: Double(b / 255),
                alpha: 1
            )
        )
    }
    
    func setFillColor(_ r: Float, _ g: Float, _ b: Float) {
        renderer.setFillColor([
            r / 255,
            g / 255,
            b / 255
        ])
    }
}
