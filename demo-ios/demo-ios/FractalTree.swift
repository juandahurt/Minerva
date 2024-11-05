//
//  FractalTree.swift
//  demo-ios
//
//  Created by Juan David Hurtado on 1/11/24.
//

import Minerva

class FractalTree: Sketch {
    override func draw() {
        translate(width / 2, height)
        rotate(.random(in: -(.pi / 4)...(.pi / 4)))
        branch(height: 200)
    }
    
    func branch(height: Float) {
        line(0, 0, 0, -height)
        translate(0, -height)
        guard height > 5 else { return }
        let branches = Int.random(in: 1...4)
        for _ in 0..<branches {
            push()
            rotate(.random(in: -(.pi / 4)...(.pi / 4)))
            branch(height: height * .random(in: 0.5...0.9))
            pop()
        }
    }
}
