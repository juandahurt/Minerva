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
        view.addSubview(sketch.view)
        
        NSLayoutConstraint.activate([
            sketch.view.topAnchor.constraint(equalTo: view.topAnchor),
            sketch.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sketch.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sketch.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
#endif

