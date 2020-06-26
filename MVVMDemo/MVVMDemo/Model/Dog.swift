//
//  Dog.swift
//  MVVMDemo
//
//  Created by Yasharth Saxena on 27/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import Foundation

class Dog {
    var name: String
    var birthdate: Date
    var hasPedigree: Bool
    var breed: String
    var color: String
    let fiveYearsAndThreeMonths = 167615983.0
    
    init(name: String, birthdate: Date, hasPedigree: Bool, breed: String, color: String) {
        self.name = name
        self.birthdate = birthdate
        self.hasPedigree = hasPedigree
        self.breed = breed
        self.color = color
    }
    
    init() {
        self.name = "Buddy"
        self.birthdate = Date(timeInterval: -fiveYearsAndThreeMonths, since: Date())
        self.hasPedigree = true
        self.breed = "Beagle"
        self.color = "Tricolor"
    }
}
