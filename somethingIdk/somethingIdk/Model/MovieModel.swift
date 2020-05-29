//
//  MovieModel.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 27/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import Foundation

struct MovieModel: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let id: Int
    let name: String?
    let title: String?
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, title, posterPath = "poster_path", backdropPath = "backdrop_path"
    }
}
