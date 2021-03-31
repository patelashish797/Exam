//
//  APIError.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import Foundation

enum APIError: LocalizedError, Equatable {
    case urlError
    case parshingEror
    case dataIsNil
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .parshingEror, .dataIsNil, .urlError:
            return "something went wrong, try again later."
        }
    }
}
