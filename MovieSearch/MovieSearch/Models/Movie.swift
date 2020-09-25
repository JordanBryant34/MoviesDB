//
//  Movie.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let rating: Double
    let releaseDate: String?
    let posterImagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case releaseDate = "release_date"
        case id = "id"
        case title = "title"
        case overview = "overview"
        case posterImagePath = "poster_path"
    }
}
