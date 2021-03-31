//
//  SchoolNameModel.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import Foundation

struct SchoolName : Codable {
    let schoolName: String
    let schoolID: String
    private enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case schoolID = "dbn"
    }
}


struct SchoolScore : Codable {
    let schoolID: String
    let satTestTakers: String
    let satCriticalReadingScore: String
    let satMathScore: String
    let satWritingScore: String
    
    private enum CodingKeys: String, CodingKey {
        case satTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingScore = "sat_critical_reading_avg_score"
        case satMathScore = "sat_math_avg_score"
        case satWritingScore = "sat_writing_avg_score"
        case schoolID = "dbn"
    }
    
}
