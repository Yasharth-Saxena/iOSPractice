//
//  MainCollectionViewCell.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 26/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    static let identifier = "MainCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
}
