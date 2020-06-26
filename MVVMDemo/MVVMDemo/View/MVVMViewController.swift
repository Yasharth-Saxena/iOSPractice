//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Yasharth Saxena on 27/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class MVVMViewController: UIViewController {

    private var dogViewModel = DogViewModel(dog: Dog())
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var age: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateScreen()
    }
    
    func updateScreen() {
        name.attributedText = dogViewModel.name
        breed.text = dogViewModel.breed
        color.text = dogViewModel.color
        age.text = dogViewModel.age
    }
}

