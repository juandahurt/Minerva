//
//  DrawableLibrary.swift
//  lulolib
//
//  Created by Juan Hurtado on 19/10/24.
//

class DrawableLibrary: Library {
    var dictionary: [DrawableType: Drawable] = [:]
    
    enum DrawableType {
        case line
    }
    
    func load() {
        dictionary[.line] = Line(device: GraphicsContext.instance.device)
    }
    
    func getValue(ofKey key: DrawableType) -> Drawable {
        guard let drawable = dictionary[key] else {
            fatalError("drawable not found")
        }
        return drawable
    }
}
