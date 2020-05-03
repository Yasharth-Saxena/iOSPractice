//
//  ViewController.swift
//  AppLocalization
//
//  Created by Yasharth Saxena on 28/04/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bigLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smallLabel.text = NSLocalizedString("SomeKey", comment: "App Localization")
        configureImageView()
        configureRTL()

    }
    
    private func configureImageView() {
        let nameOfImage = NSLocalizedString("SomeImage", comment: "Image for Different Languages")
        self.imageView.image = UIImage(named: nameOfImage)
    }
    
    private func configureRTL() {
        if #available(iOS 9.0, *) {
            if UIView.userInterfaceLayoutDirection(for: self.view.semanticContentAttribute) == .rightToLeft {
                smallLabel.textAlignment = .right
            } else {
                smallLabel.textAlignment = .left
            }
        }
    }
    
    


}

