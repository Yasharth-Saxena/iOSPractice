//
//  AnotherViewController.swift
//  ProgrammingPractice
//
//  Created by Yasharth Saxena on 25/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {
    let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstFirstView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "shibaOne"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(firstView)
        firstView.addSubview(firstImage)
        view.addSubview(secondView)
    }
    
    private func setupLayout() {
        // constraints for the firstView
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])

        // constraints for the firstImage
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: firstView.topAnchor),
            firstImage.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            firstImage.bottomAnchor.constraint(equalTo: firstView.bottomAnchor),
            firstImage.widthAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 0.5)
        ])
        
        // constraints for the second view
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondView.heightAnchor.constraint(equalTo: firstView.heightAnchor)
        ])
    }
}
