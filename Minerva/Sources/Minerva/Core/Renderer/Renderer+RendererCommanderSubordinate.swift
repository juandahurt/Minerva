//
//  Renderer+RendererCommanderSubordinate.swift
//  Minerva
//
//  Created by Juan Hurtado on 30/10/24.
//

extension Renderer: RendererCommanderSubordinate {
    func rendererCommander(_ commander: RendererCommander, commands command: RendererCommand) {
        commands.append(command)
    }
}
