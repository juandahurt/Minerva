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
        sketch.view.frame = view.bounds
    }
}
#endif

