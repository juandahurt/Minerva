//
//  ViewController.swift
//  demo-ios
//
//  Created by Juan Hurtado on 12/10/24.
//

import UIKit
import lulolib

class MySketch1: Sketch {
    var x: Float = 0
    var y: Float = 0
    
    override func draw() {
        line(x, 80, 100, y)
        line(250, y, 230, y)
        
        x = .random(in: 0...400)
        y = .random(in: 0...450)
    }
}

class MySketch2: Sketch {
    var x: Float = 0
    var y: Float = 0
    
    override func draw() {
        line(0, 0, 200, 400)
    }
}

class ViewController: UIViewController {
    let sketch1 = MySketch1()
    let sketch2 = MySketch2()
    
    let container1 = UIView()
    let container2 = UIView()
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        
        view.addSubview(stackView)
        
        container1.translatesAutoresizingMaskIntoConstraints = false
        container1.addSketch(sketch1)
        stackView.addArrangedSubview(container1)
//
        stackView.addArrangedSubview(container2)
        container2.addSketch(sketch2)
        container2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

