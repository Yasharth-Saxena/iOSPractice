//
//  ViewController.swift
//  ProgrammaticUI
//
//  Created by Yasharth Saxena on 24/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // this is the background wallpaper for the screen
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
        // this line lets xcode know that we want to use AutoLayout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // this is the panda image on the screen
    let mainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cutePanda"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // the button that adds the border to the panda image
    let addBorderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Pardon the beautiful interface I was just practicing :)"
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImageView()
        setupMainImageView()
        setupButton()
        setupTextView()
    }
    
    private func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        // setting constraints for the backgroundImageView
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // sends the backgroundImageView to the beginning of the array of views in the subviews property
        backgroundImageView.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupMainImageView() {
        view.addSubview(mainImageView)
        mainImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupButton() {
        view.addSubview(addBorderButton)
        // customizing the addBorderButton
        addBorderButton.setTitle("Add Border", for: .normal)
        addBorderButton.setTitleColor(.blue, for: .normal)
        addBorderButton.backgroundColor = .cyan
        addBorderButton.showsTouchWhenHighlighted = true
        
        // adding the target action for the button
        addBorderButton.addTarget(self, action: #selector(ViewController.addBorderToImage), for: .touchUpInside)
        
        // adding constraints for the button
        addBorderButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30).isActive = true
        addBorderButton.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor).isActive = true
        addBorderButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }
    
    // this is the action for the addBorderButton
    @objc func addBorderToImage() {
        mainImageView.layer.borderColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        mainImageView.layer.masksToBounds = true
        mainImageView.contentMode = .scaleToFill
        mainImageView.layer.borderWidth = 5
    }
    
    private func setupTextView() {
        view.addSubview(descriptionTextView)
        
        // adding constraints
        descriptionTextView.topAnchor.constraint(equalTo: addBorderButton.bottomAnchor, constant: 30).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true 
    }

    
}



