//
//  SchoolInfoViewModel.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import Foundation

protocol SchoolInfoViewModelDelegate: class {
    func onFetchSchoolInfoCompleted()
    func onFetchFailed(with reason: String)
}

class SchoolInfoViewModel {
    
    private weak var delegate: SchoolInfoViewModelDelegate?
    var schoolNames: [SchoolName] = []
    var schoolInfoDictionary: [String: SchoolScore] = [:]
    let group = DispatchGroup()

    
    init(delegate: SchoolInfoViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchSchoolInfo() {
        group.enter()
        NetworkManager.shared.getSchoolNames { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let schoolNames):
                self.schoolNames = schoolNames
            case .failure(let error):
                self.delegate?.onFetchFailed(with: error.localizedDescription)
            }
            self.group.leave()
        }

        group.enter()
        NetworkManager.shared.getSchoolScores { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let schoolsScores):
                schoolsScores.forEach { (score) in
                    self.schoolInfoDictionary[score.schoolID] = score
                }
            case .failure(let error):
//                self.delegate?.onFetchFailed(with: error.localizedDescription)
                print(error.localizedDescription)
/*
             this is being just commented because if both the service get faild then this will give error diloag two times
*/
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.onFetchSchoolInfoCompleted()
        }
        
    }
    
    func getScoreInfoFor(id: String) -> String {
        let schoolScore = schoolInfoDictionary[id]
        var scoreInfoString = ""
        
        if let satTestTakers = schoolScore?.satTestTakers {
            scoreInfoString.append("\nNum of SAT Test Takers : \(satTestTakers)")
        }
        if let satCriticalReadingScore = schoolScore?.satCriticalReadingScore {
            scoreInfoString.append("\nSAT Critical Reading Score : \(satCriticalReadingScore)")
        }
        if let satMathScore = schoolScore?.satMathScore {
            scoreInfoString.append("\nSAT Math Score : \(satMathScore)")
        }
        if let satWritingScore = schoolScore?.satWritingScore {
            scoreInfoString.append("\nSAT Writing Score : \(satWritingScore)")
        }
        
        if scoreInfoString == "" {
            return "information is not available."
        }
        return scoreInfoString
    }
}
