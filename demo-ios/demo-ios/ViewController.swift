//
//  ViewController.swift
//  demo-ios
//
//  Created by Juan Hurtado on 12/10/24.
//

import UIKit
import lulolib

class MySketch: Sketch {
    
}

class ViewController: UIViewController {
    let sketch = MySketch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSketch(sketch)
    }
}

