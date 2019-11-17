//
//  Movie.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation
import UIKit

struct MovieApiResponse : Codable {
    let movies : [Movie]?
    let totalResults : String?
    let response : String?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case movies = "Search"
        case totalResults = "totalResults"
        case response = "Response"
        case error = "Error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies)
        totalResults = try values.decodeIfPresent(String.self, forKey: .totalResults)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}


struct Movie : Codable {
    let title : String?
    let year : String?
    let imdbID : String?
    let type : String?
    let poster : String?

    enum CodingKeys: String, CodingKey {

        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
    }

}

