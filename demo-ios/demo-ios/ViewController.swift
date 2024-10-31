//
//  ViewController.swift
//  demo-ios
//
//  Created by Juan Hurtado on 12/10/24.
//

import UIKit
import Minerva

class MySketch1: Sketch {
    override func draw() {
        translate(width / 2, height)
        line(0, 0, 0, -200)
        
        rotate(45)
        translate(0, -200)
        line(0, 0, 0, -200)
//        branch(depth: 2)
    }
    
//    func branch(depth: Int, angle: Float = 0) {
//        guard depth > 0 else { return }
//        rotate(angle)
//        translate(0, -200)
//        line(0, 0, 0, -200)
//        
//        branch(depth: depth - 1, angle: 45)
//        branch(depth: depth - 1, angle: -45)
//    }
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
    
    let numParticles = 100
    var particles: [Particle] = []
    
    
    override func setup() {
        for _ in 0..<numParticles {
            particles.append(.init(canvasWidth: width, canvasHeight: height))
        }
    }
    
    override func draw() {
//        background(110, 230, 20)
//        fill(150, 200, 100)
        for i in particles.indices {
            particles[i].update()
            rect(particles[i].x, particles[i].y, 30, 30)
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
        
//        stackView.addArrangedSubview(container2)
//        container2.addSketch(sketch2)
//        container2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

