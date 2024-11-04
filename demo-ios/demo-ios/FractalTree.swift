//
//  FractalTree.swift
//  demo-ios
//
//  Created by Juan David Hurtado on 1/11/24.
//

import Minerva

class FractalTree: Sketch {
    override func draw() {
        let length: Float = 200
        translate(width / 2, height)
        line(0, 0, 0, -length)
        translate(0, -length)
        rotate(45)
        
        line(0, 0, 0, -length)
        translate(0, -length)
        rotate(45)

        line(0, 0, 0, -length)
//        branch(length: 200)
    }
    
    func branch(length: Float) {
//        if length < 40 { return }
        line(0, 0, 0, -length)
        translate(0, -length)
        rotate(45)
        
        line(0, 0, 0, -length)
        translate(0, -length)
        rotate(45)

        line(0, 0, 0, -length)
        
//        translate(0, -length)
//        rotate(45)
//        branch(length: length * 0.7)
        
//        translate(0, -length)
//        rotate(-45)
//        branch(length: length * 0.7)
    }
}
