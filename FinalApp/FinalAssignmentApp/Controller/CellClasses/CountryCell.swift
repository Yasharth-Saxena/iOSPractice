//
//  CountryCell.swift
//  FinalAssignmentApp
//
//  Created by Yasharth Saxena on 13/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

