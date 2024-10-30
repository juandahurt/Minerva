//
//  ViewController.swift
//  demo-ios
//
//  Created by Juan Hurtado on 12/10/24.
//

import UIKit
import Minerva

class MySketch1: Sketch {
    var x: Float = 0
    var y: Float = 0
    
    override func draw() {
        line(0, 100, 120, 50)
        line(54, 400, 120, 50)
        triangle(100, 75, 40, 20, 70, 75)
        line(200, 400, 500, 100)
        rect(x: 100, y: 350, w: 100, h: 20)
    }
}

struct Particle {
    var velX: Float = -1
    var velY: Float = 2
    
    var x: Float
    var y: Float
    
    var width: Float
    var height: Float
    
    init(canvasWidth: Float, canvasHeight: Float) {
        self.width = canvasWidth
        self.height = canvasHeight
        
        x = 10
        y = 10
        
        velX = .random(in: -10...10)
        velY = .random(in: -10...10)
    }
    
    mutating func update() {
        if x > width {
            velX *= -1
        }
        if x < 0 {
            velX *= -1
        }
        
        if y < 0 {
            velY *= -1
        }
        if y > height {
            velY *= -1
        }
        
        x += velX
        y += velY
    }
}

class MySketch2: Sketch {
    var x: Float = 30
    var y: Float = 0
    
    let numParticles = 10
    var particles: [Particle] = []
    
    
    override func setup() {
        background(40, 130, 29)
        for _ in 0..<numParticles {
            particles.append(.init(canvasWidth: width, canvasHeight: height))
        }
    }
    
    override func draw() {
        background(11, 230, 20)
        fill(150, 200, 100)
        for i in particles.indices {
            particles[i].update()
            rect(x: particles[i].x, y: particles[i].y, w: 30, h: 30)
        }
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

