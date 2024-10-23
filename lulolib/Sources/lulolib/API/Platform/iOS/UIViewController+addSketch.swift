//
//  UIViewController+addSketch.swift
//  
//
//  Created by Juan Hurtado on 12/10/24.
//

#if canImport(UIKit)
import UIKit


public extension UIViewController {
    func addSketch(_ sketch: Sketch) {
        view.addSketch(sketch)
    }
}

public extension UIView {
    func addSketch(_ sketch: Sketch) {
        addSubview(sketch.view)
        NSLayoutConstraint.activate([
            sketch.view.topAnchor.constraint(equalTo: topAnchor),
            sketch.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            sketch.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            sketch.view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
#endif

