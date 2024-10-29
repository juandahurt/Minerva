//
//  Sketch.swift
//  
//
//  Created by Juan Hurtado on 12/10/24.
//

import Foundation

open class Sketch {
    /// Canvas width
    public var width: Float = 0
    /// Canvas height
    public var height: Float = 0
    
    lazy var view: SketchView = {
        let view = SketchView()
        view.sketch = self
        return view
    }()
    
    public init() {}
    
    open func setup() {}
    
    open func draw() {}
}