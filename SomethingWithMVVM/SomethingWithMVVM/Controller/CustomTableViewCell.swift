//
//  CustomTableViewCell.swift
//  SomethingWithMVVM
//
//  Created by Yasharth Saxena on 29/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    public func configureUI(userId: Int, id: Int, title: String) {
        self.userIdLabel.text = "UserId: \(userId)"
        self.idLabel.text = "Id: \(id)"
        self.titleLabel.text = "Title: \(title)"
    }

}
