//
//  ExampleViewController.swift
//  demo-ios
//
//  Created by Juan Hurtado on 5/11/24.
//

import Minerva
import UIKit

class ExampleViewController: UIViewController {
    var sketch: Sketch
    
    private var sketchContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    init(sketch: Sketch) {
        self.sketch = sketch
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExampleViewController {
    func setupSubviews() {
        setupContainerView()
        setupSketchView()
    }
    
    func setupContainerView() {
        view.addSubview(sketchContainerView)
        
        NSLayoutConstraint.activate([
            sketchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sketchContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sketchContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sketchContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupSketchView() {
        sketchContainerView.addSketch(sketch)
    }
}
