//
//  LibrariesContainer.swift
//  Minerva
//
//  Created by Juan Hurtado on 19/10/24.
//

class LibrariesContainer {
    private init() {}
    
    static let renderPipelineStateLibrary = RenderPipelineStateLibrary()
    static let drawableLibrary = DrawableLibrary()
    
    static func load() {
        renderPipelineStateLibrary.load()
        drawableLibrary.load()
    }
}
