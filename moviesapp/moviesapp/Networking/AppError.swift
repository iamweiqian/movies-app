//
//  AppError.swift
//  MoviesApp
//
//  Created by Wei Qian on 31/08/2018.
//  Copyright © 2018 Yap Wei Qian. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case fileNotFound
    case custom(message: String)
    
    var ErrorMessage: String {
        switch self {
        case .fileNotFound:
            return "File Not Found"
        case .custom(let message):
            return message
        }
    }
}
