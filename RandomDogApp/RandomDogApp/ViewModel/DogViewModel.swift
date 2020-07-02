//
//  ImageViewModel.swift
//  RandomDogApp
//
//  Created by Yasharth Saxena on 02/07/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class DogViewModel {
    enum Endpoint: String {
        case randomImageFromDogCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            // here I'm just gonna unwrap it because I know for sure that this is a valid URL
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestRandomImage(with url: URL, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, error!)
                return
            }
            
            do {
                let dogModel = try JSONDecoder().decode(DogImage.self, from: data)
                completionHandler(dogModel, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class func requestImageFile(with url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, error == nil else {
                completionHandler(nil, error!)
                return
            }
            
            let downloadedImage = UIImage(data: imageData)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
    
    
}
