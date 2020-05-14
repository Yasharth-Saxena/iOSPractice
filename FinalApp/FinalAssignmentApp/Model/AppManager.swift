//
//  AppManager.swift
//  FinalAssignmentApp
//
//  Created by Yasharth Saxena on 14/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit


struct AppManager {
    fileprivate let baseURLString = "https://restcountries.eu/rest/v2/all"
    
    func performRequest(completionHandler: @escaping  (Result<[CountryModel],Error>) -> ()) {
        if let url = URL(string: baseURLString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print("API Status: \(httpResponse.statusCode)")
                }
                
                guard let validData = data, error == nil else {
                    completionHandler(.failure(error!))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([CountryModel].self, from: validData)
                    completionHandler(.success(decodedData))
                } catch {
                    completionHandler(.failure(error))
                }
                
            }.resume()
        }
    }
    
}
