//
//  Movie+API.swift
//  MoviesApp
//
//  Created by Wei Qian on 31/08/2018.
//  Copyright © 2018 Yap Wei Qian. All rights reserved.
//

import UIKit
import SwiftyJSON

extension Movie {
    
    public static func getMovieList(completion: @escaping (_ movieList: [Movie], _ error: Error?) -> Void) {
        
        guard let filePath = Bundle.main.url(forResource: "movie",
                                             withExtension: "json") else {
                                                completion([], AppError.fileNotFound)
                                                return
        }
        
        do {
            let data = try Data.init(contentsOf: filePath)
            let json = try JSON(data: data)
            let list: [Movie] = try json.arrayValue.map { try Movie.parse($0) }
            completion(list, nil)
        } catch {
            completion([], error)
        }
    }
    
}
