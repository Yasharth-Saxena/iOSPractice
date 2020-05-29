//
//  TrendingCollectionViewCell.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 27/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrendingCollectionViewCell"
    
    @IBOutlet weak var trendingImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

}
