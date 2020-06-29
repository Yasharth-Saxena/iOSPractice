//
//  Model.swift
//  SomethingWithMVVM
//
//  Created by Yasharth Saxena on 29/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

struct UserModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
