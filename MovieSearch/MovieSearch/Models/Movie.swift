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

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let rating: Double
    let releaseDate: String?
    let posterImagePath: String?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case releaseDate = "release_date"
        case id = "id"
        case title = "title"
        case overview = "overview"
        case posterImagePath = "poster_path"
        case popularity = "popularity"
    }
}

extension Movie: Equatable {}

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.overview == rhs.overview
}
