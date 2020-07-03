//
//  ImageViewModel.swift
//  RandomDogApp
//
//  Created by Yasharth Saxena on 02/07/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class DogViewModel {
    // enums having associated values can't have a rawValue
    enum Endpoint {
        case randomImageFromDogCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            // here I'm just gonna unwrap it because I know for sure that this is a valid URL
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromDogCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
        
    }
    
    // gets the json and converts it to the DogImage struct instance
    class func requestRandomImageData(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndpoint = self.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
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
    
    // gets a random image in accordance with the DogImage struct's instance
    class func requestRandomImageFile(with url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let downloadedImage = UIImage(data: imageData)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
    
    // gets all the breeds of dogs available in the API and puts them in an array of strings
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let breedListEndpoint = self.Endpoint.listAllBreeds.url
        let task = URLSession.shared.dataTask(with: breedListEndpoint) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler([], error)
                return
            }
            
            do {
                let breedsListResponse = try JSONDecoder().decode(BreedsList.self, from: data)
                // this maps the keys of the breedsListResponse dictionary in an array called breedsList
                let breedsList = breedsListResponse.message.keys.map({$0})
                completionHandler(breedsList, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}
