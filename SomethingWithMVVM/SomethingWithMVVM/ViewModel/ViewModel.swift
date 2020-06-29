//
//  ViewModel.swift
//  SomethingWithMVVM
//
//  Created by Yasharth Saxena on 29/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit
import Alamofire

// subset of some data in the model
class ViewModel {
    static let shared = ViewModel() 
    fileprivate let baseURLString = "https://jsonplaceholder.typicode.com/todos"
    var dataArray = [UserModel]()

    func getUserDataUsingAF(completion: @escaping (Swift.Result<[UserModel], Error>) -> Void) {
        Alamofire.request(baseURLString).response { (response) in
            
            guard let data = response.data, response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([UserModel].self, from: data)
                self.dataArray.append(contentsOf: decodedData)
                completion(.success(self.dataArray))

            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
//    func getUserData(completion: @escaping (Swift.Result<[UserModel], Error>) -> Void) {
//        if let url = URL(string: baseURLString) {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let httpResponse = response as? HTTPURLResponse {
//                    print("API Status: \(httpResponse.statusCode)")
//                }
//
//                guard let validData = data, error == nil else {
//                    print("API Error: \(error!)")
//                    return
//                }
//
//                do {
//                    let decodedData = try JSONDecoder().decode([UserModel].self, from: validData)
//                    self.dataArray.append(contentsOf: decodedData)
//                    completion(.success(self.dataArray))
//
//                } catch {
//                    completion(.failure(error))
//                }
//            }.resume()
//        }
//    }
    
    
}
