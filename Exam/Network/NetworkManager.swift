//
//  NetworkManager.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //https://data.cityofnewyork.us/resource/s3k6-pzi2.json
    var schoolNameURLComponents: URLComponents = {
        var componet = URLComponents()
        componet.scheme = "https"
        componet.host = "data.cityofnewyork.us"
        componet.path = "/resource/s3k6-pzi2.json"
        return componet
    }()

    //https://data.cityofnewyork.us/resource/f9bf-2cp4.json
    var schoolScoreURLComponents: URLComponents = {
        var componet = URLComponents()
        componet.scheme = "https"
        componet.host = "data.cityofnewyork.us"
        componet.path = "/resource/f9bf-2cp4.json"
        return componet
    }()

    
    func getSchoolNames(onComplition: @escaping (Result<[SchoolName], APIError>) -> Void) {
        
        guard let url = schoolNameURLComponents.url else {
            onComplition(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let _ = response {
                do {
                    let names = try JSONDecoder().decode([SchoolName].self, from: data)
                    onComplition(.success(names))
                } catch {
                    onComplition(.failure(.parshingEror))
                }
            }
            if let error = error {
                onComplition(.failure(.failedRequest(description: error.localizedDescription)))
            }
            
            
        }.resume()
    }
    
    func getSchoolScores(onComplition: @escaping (Result<[SchoolScore], APIError>) -> Void) {
        
        guard let url = schoolScoreURLComponents.url else {
            onComplition(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let _ = response {
                do {
                    let scores = try JSONDecoder().decode([SchoolScore].self, from: data)
                    onComplition(.success(scores))
                } catch {
                    onComplition(.failure(.parshingEror))
                }
            }
            if let error = error {
                onComplition(.failure(.failedRequest(description: error.localizedDescription)))
            }
        }.resume()
    }
    
    
}
