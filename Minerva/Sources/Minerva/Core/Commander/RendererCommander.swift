//
//  RendererCommander.swift
//  Minerva
//
//  Created by Juan Hurtado on 30/10/24.
//

protocol RendererCommanderSubordinate: AnyObject {
    func rendererCommander(_ commander: RendererCommander, commands command: RendererCommand)
}

class RendererCommander {
    weak var subordinate: RendererCommanderSubordinate?
    
    func pushCommand(_ command: RendererCommand) {
        subordinate?.rendererCommander(self, commands: command)
    }
}
