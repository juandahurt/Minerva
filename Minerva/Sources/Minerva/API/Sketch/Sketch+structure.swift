//
//  Sketch+structure.swift
//
//
//  Created by Juan David Hurtado on 31/10/24.
//

import Foundation

public extension Sketch {
    func push() {
        rendererCommander.pushCommand(
            .structure(.push)
        )
    }
    
    func pop() {
        rendererCommander.pushCommand(
            .structure(.pop)
        )
    }
}
