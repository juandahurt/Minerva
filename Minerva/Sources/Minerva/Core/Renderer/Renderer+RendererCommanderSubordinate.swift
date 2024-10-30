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
    
    func commandNotifier(_ notifier: RendererCommander, didPushCommand command: RendererCommand) {
        switch command {
        case .shape(let shapeCommand):
            addDrawable(fromCommand: shapeCommand)
        }
    }
}
