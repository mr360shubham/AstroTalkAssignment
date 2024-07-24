//
//  MovieResponseModel.swift
//  AstrotalkAssisgnment
//
//  Created by Shubham Baliyan on 10/07/24.
//

import Foundation

// MARK: model for movie
struct MovieResponse: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let imdbID: String?
    let Title: String?
    let Year: String?
    let Poster: String?
}
