//
//  Movie.swift
//  MoviesApp
//
//  Created by Wei Qian on 31/08/2018.
//  Copyright © 2018 Yap Wei Qian. All rights reserved.
//

import UIKit
import JSONParsing

public final class Movie: JSONParseable {
    
    public var id: Int
    public var title: String
    public var year: String
    public var storyline: String
//    public var actors: [String]
    public var posterUrl: String
    
    init(id: Int, title: String, year: String, storyline: String, posterUrl: String) {
        self.id = id
        self.title = title
        self.year = year
        self.storyline = storyline
        self.posterUrl = posterUrl
    }
    
    public static func parse(_ json: JSON) throws -> Movie {
        return try Movie(id: json["id"]^, title: json["title"]^, year: json["year"]^, storyline: json["storyline"]^, posterUrl: json["posterurl"]^)
    }
    
}
