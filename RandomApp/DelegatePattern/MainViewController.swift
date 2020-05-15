//
//  ViewController.swift
//  DelegatePattern
//
//  Created by Yasharth Saxena on 13/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let countryVC = CountryViewController()

    @IBOutlet weak var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let countryVC = storyboard?.instantiateViewController(identifier: "CountryView") as! CountryViewController
        countryVC.delegate = self 
    }
    

}

extension MainViewController: CountryDelegate {
    func didUpdateCountry(_ name: String) {
        DispatchQueue.main.async {
            self.mainLabel.text = name
        }
    }
}


