//
//  ViewController.swift
//  ProgrammingPractice
//
//  Created by Yasharth Saxena on 25/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    let mainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bear_first"))
        // this allows the image to maintain the aspect ratio and not stretch
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        // this can add stylised text
        let attributedText = NSMutableAttributedString(string: "Just a random practice application!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSMutableAttributedString(string: "\n\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi accumsan consequat quam in consequat. Fusce vitae tellus magna. Mauris sollicitudin, sem in scelerisque gravida, ante nulla dictum augue, eget interdum metus ligula quis odio.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemGray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let containerForMainImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .blue
        return view
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupLayout()
        setupBottomControlStackView()
    }
    
    //MARK: Helper functions
    
    private func addSubviews() {
        view.addSubview(containerForMainImageView)
        containerForMainImageView.addSubview(mainImageView)
        view.addSubview(descriptionTextView)
    }
    
    private func setupBottomControlStackView() {
//        let redView = UIView()
//        redView.backgroundColor = .red
//
//        let greenView = UIView()
//        greenView.backgroundColor = .green
//
//        let blueView = UIView()
//        blueView.backgroundColor = .blue
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlStackView.distribution = .fillEqually
        view.addSubview(bottomControlStackView)
        
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // adding constraints for the stack view to pin it to the bottom
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func setupLayout() {
        // constraints for the container view
        containerForMainImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerForMainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerForMainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        /// makes the height of the container view half times the height of the view
        containerForMainImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        // constraints for the mainImageView
        mainImageView.centerXAnchor.constraint(equalTo: containerForMainImageView.centerXAnchor).isActive = true
        mainImageView.centerYAnchor.constraint(equalTo: containerForMainImageView.centerYAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: containerForMainImageView.heightAnchor, multiplier: 0.6).isActive = true
        
        // constraints for the descriptionTextView
        descriptionTextView.topAnchor.constraint(equalTo: containerForMainImageView.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }

}

