//
//  ViewController.swift
//  demo-ios
//
//  Created by Juan Hurtado on 12/10/24.
//

import UIKit
import lulolib

class MySketch: Sketch {
    var x: Float = 0
    var y: Float = 0
    
    override func draw() {
        line(x, 80, 100, y)
        line(250, y, 230, y)
        
        x = .random(in: 0...400)
        y = .random(in: 0...450)
    }
}

class ViewController: UIViewController {
    let sketch = MySketch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSketch(sketch)
    }
}

