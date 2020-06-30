//
//  ViewController.swift
//  SomethingWithMVVM
//
//  Created by Yasharth Saxena on 29/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = ViewModel() 
    
    let mainTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let executeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Execute", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainTextView)
        view.addSubview(executeButton)
        
        // sets constraints for the mainScreen's subviews
        viewModel.setConstraints(textView: self.mainTextView, button: self.executeButton, view: self.view)
        
        executeButton.addTarget(self, action: #selector(executeButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func executeButtonTapped() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return
        }
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        viewModel.performRequest(url) { (dataArray, error) in
            if let dataArray = dataArray {
                self.mainTextView.text = dataArray.description
            } else if let error = error {
                self.mainTextView.text = error.localizedDescription
            }
        }
    }
    
    
}
